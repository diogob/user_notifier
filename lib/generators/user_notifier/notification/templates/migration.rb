class Create<%= notifications_table_name.camelize %> < ActiveRecord::Migration
  def change
    create_table :<%= notifications_table_name %> do |t|
      t.integer :<%= user_model_name %>_id, null: false
      <%= "t.integer :#{table_name.singularize}_id, null: false" unless is_user_model? %>
      t.text :from_email, null: false
      t.text :from_name, null: false
      t.text :template_name, null: false
      t.text :locale, null: false
      t.text :cc
      t.timestamp :sent_at
      t.timestamp :deliver_at
      t.timestamps
    end
  end
end
