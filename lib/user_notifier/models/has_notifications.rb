module UserNotifier
  module NotificationSource
    extend ActiveSupport::Concern

    included do
      def notify template_name, user=nil, source=nil, params={}
        user ||= self
        source ||= self
        self.notifications.notify(template_name, user, source, params)
      end

      def notify_once template_name, user=nil, source=nil, params={}
        user ||= self
        source ||= self
        self.notifications.notify_once(template_name, user, source, params)
      end
    end

    module ClassMethods
      private
      def set_association
        create_notification_class
        self.has_many :notifications, class_name: notification_class_name, dependent: :destroy
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

          source_name = self.table_name.singularize
          if self.model_name.to_s.downcase != UserNotifier.user_class_name.downcase
            klass.belongs_to source_name.to_sym, inverse_of: :notifications
          end
          klass.belongs_to :source, class_name: self.model_name.to_s, foreign_key: "#{source_name}_id", inverse_of: :notifications
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
