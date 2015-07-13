require 'spec_helper'

describe UserNotifier::Base do
  let(:user){ User.create email: 'foo@bar.com' }
  let(:order){ Order.create user_id: user.id, title: 'test' }
  let(:notification){ UserNotification.notify('test', user) }
  before{ order }


  describe "associations" do
    context "in user model" do
      subject{ user }
      it{ should have_many :notifications }
    end

    context "in notifications model" do
      subject{ notification }
      it{ should belong_to :user }
    end
    context "in notifications model when notification source is not the user" do
      let(:notification){ OrderNotification.notify('test', user, order) }
      subject{ notification }
      it{ should belong_to :user }
      it{ should belong_to :order }
      it{ should belong_to :source } # just an alias for order
    end
  end

  describe ".notify_once" do
    before{ notification }

    it "should create notification in the database" do
      expect(UserNotification.last).to be_present
    end

    it "should not create notification for same association and different template name" do
      UserNotification.notify_once('another_test', user)
      expect(UserNotification.count(:all)).to eq 2
    end

    it "should not create duplicate notification for same association and template name" do
      UserNotification.notify_once('test', user)
      expect(UserNotification.count(:all)).to eq 1
    end
  end

  describe ".notify" do
    subject{ notification }

    context "direct notification" do
      it "should create notification in the database" do
        subject
        expect(UserNotification.last).to be_present
      end

      its(:template_name){ should eq 'test' }
      its(:deliver_at){ should be_kind_of(Time) }
    end

    context "with scheduled notification" do
      let(:deliver_at) { 3.days.from_now }
      let(:notification) {  UserNotification.notify('deliver_at_test', user, nil, {deliver_at: deliver_at}) }
      it "should create notification in the database" do
        subject
        expect(UserNotification.last).to be_present
      end

      its(:template_name){ should eq 'deliver_at_test' }
      its(:deliver_at){ should eq deliver_at }
    end
  end

  describe "#deliver" do
    context "when sent_at is present" do
      before do
        notification.sent_at = Time.now
      end

      it "should not call deliver!" do
        expect(notification).to_not receive(:deliver!)
        notification.deliver
      end
    end

    context "when sent_at is nil" do
      before do
        notification.sent_at = nil
      end

      it "should call deliver!" do
        expect(notification).to receive(:deliver!)
        notification.deliver
      end
    end
  end

  describe "#deliver!" do
    before do
      notification.deliver!
    end
  end
end
