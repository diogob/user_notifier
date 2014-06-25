require 'spec_helper'

describe UserNotifier::Configuration do
  before do
    UserNotifier.reset
  end

  UserNotifier::Configuration::VALID_CONFIG_KEYS.each do |key|
    describe ".#{key}" do
      it 'should return the default value' do
        expect(UserNotifier.send(key)).to eq UserNotifier::Configuration.const_get("DEFAULT_#{key.upcase}")
      end
    end
  end

  describe '.configure' do
    UserNotifier::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        UserNotifier.configure do |config|
          config.send("#{key}=", key)
          expect(UserNotifier.send(key)).to eq key
        end
      end
    end
  end
end
