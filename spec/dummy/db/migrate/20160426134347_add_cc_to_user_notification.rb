class AddCcToUserNotification < ActiveRecord::Migration
  def up
    add_column :user_notifications, :cc, :text
  end

  def down
    remove_column :user_notifications, :cc, :text
  end

end
