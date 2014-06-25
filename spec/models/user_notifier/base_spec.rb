require 'spec_helper'

describe UserNotifier::Base do
  let(:user){ User.create email: 'foo@bar.com' }

  describe "associations" do
    subject{ user }
    it{ should have_many :notifications }
  end

  describe ".notify" do
    before do
      user.notify :test
    end

    it "should create notification in the database" do
      expect(UserNotification.last).to be_present
    end
  end
end
