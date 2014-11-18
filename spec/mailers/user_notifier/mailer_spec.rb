require 'spec_helper'

describe UserNotifier::Mailer do
  let(:user){ User.create email: 'foo@bar.com' }
  let(:notification){ UserNotification.notify('test', user) }
  let(:mailer){ UserNotifier::Mailer }

  before{ user }

  describe "#notify" do
    subject{ mailer.notify(notification) }
    its(:from){ should eq [] }
    its(:reply_to){ should eq ["no-reply@yourdomain"] }
    its(:to){ should eq ["foo@bar.com"] }

    context "when notification's locale is en" do
      let(:notification){ UserNotification.notify('test', user, nil, {locale: :en}) }
      its(:subject){ should eq "test subject\n" }
      it "should get body in english" do
        expect(subject.body.to_s).to eq "test body\n\n"
      end
    end

    context "when notification's locale is pt" do
      let(:notification){ UserNotification.notify('test', user, nil, {locale: :pt}) }
      its(:subject){ should eq "assunto de teste\n" }
      it "should get body in english" do
        expect(subject.body.to_s).to eq "corpo de teste\n\n"
      end
    end
  end
end

