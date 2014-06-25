class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.integer :user_id
      t.text :from_email
      t.text :from_name
      t.text :template_name
      t.text :locale
      t.timestamp :sent_at
    end
  end
end
