class AddEmailColsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string
    add_column :users, :subscribed_daily_email, :boolean, default: false, null: false
  end
end
