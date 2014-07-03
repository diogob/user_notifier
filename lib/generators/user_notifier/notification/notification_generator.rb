require 'rails/generators/active_record'

module UserNotifier
  module Generators
    class NotificationGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def notifications_table_name
        "#{table_name.singularize}_notifications"
      end

      def copy_migration
        migration_template "migration.rb", "db/migrate/create_#{notifications_table_name}.rb"
      end

      private
      def user_model_name
        UserNotifier.user_class_name.downcase
      end

      def is_user_model?
        table_name.singularize == user_model_name
      end
    end
  end
end
