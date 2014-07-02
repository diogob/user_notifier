module UserNotifier
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def copy_initializer
        template 'user_notifier.rb', 'config/initializers/user_notifier.rb'
      end
    end
  end
end
