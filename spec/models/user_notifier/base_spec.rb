require 'spec_helper'

describe UserNotifier::Base do
  let(:user){ User.create email: 'foo@bar.com' }

  describe "associations" do
    subject{ user }
    it{ should have_many :notifications }
  end

  describe ".notify" do
    subject{ user.notify('test') }

    it "should create notification in the database" do
      subject
      expect(UserNotification.last).to be_present
    end

    its(:template_name){ should eq 'test' }
  end
end
