require "user_notifier/engine"
require "user_notifier/configuration"
require "sidekiq"

module UserNotifier
  extend Configuration
end

ActiveSupport.on_load :active_record do
  require "user_notifier/models/has_notifications"
end
