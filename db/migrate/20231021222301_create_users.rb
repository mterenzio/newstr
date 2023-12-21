class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :npub, index: {unique: true}
      t.string :public_key, index: {unique: true}
      t.jsonb :profile

      t.timestamps null: false
    end
  end
end
