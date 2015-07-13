class AddDeliverAtToNotifications < ActiveRecord::Migration
  def up
    add_column :order_notifications, :deliver_at, :timestamp
    add_column :user_notifications, :deliver_at, :timestamp

    execute "ALTER TABLE order_notifications ALTER deliver_at SET DEFAULT current_timestamp"
    execute "ALTER TABLE user_notifications ALTER deliver_at SET DEFAULT current_timestamp"
  end

  def down
    remove_column :order_notifications, :deliver_at, :timestamp
    remove_column :user_notifications, :deliver_at, :timestamp
  end
end
