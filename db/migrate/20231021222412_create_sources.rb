class CreateSources < ActiveRecord::Migration[7.0]
  def change
    create_table :sources do |t|
      t.string :npub, null: false, index: {unique: true}
      t.string :public_key, index: {unique: true}
      t.jsonb :profile
      t.boolean :active, default: true, null: false
      t.timestamps
    end
  end
end
