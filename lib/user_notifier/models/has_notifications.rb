module UserNotifier
  module NotificationSource
    extend ActiveSupport::Concern

    included do
      def notify template_name, user=nil
        user ||= self
        self.notifications.notify(template_name, user)
      end
    end

    module ClassMethods
      private
      def set_association
        create_notification_class
        self.has_many :notifications, class_name: notification_class_name
      end

      def notification_class_name
        "#{self.model_name}Notification"
      end

      def create_notification_class
        base_class_name = notification_class_name.demodulize
        unless self.parent.const_defined?(notification_class_name)
          klass = Class.new UserNotifier::Base do
            self.table_name = base_class_name.tableize
          end
          self.parent.const_set base_class_name, klass
        end
      end
    end
  end

  module HasNotifications
    def has_notifications
      include UserNotifier::NotificationSource
      set_association
    end
  end
end

ActiveRecord::Base.extend UserNotifier::HasNotifications
