class CreateSources < ActiveRecord::Migration[7.0]
  def change
    create_table :sources do |t|
      t.string :public_key, null: false, unique: true
      t.datetime :last_processed
      t.integer :state

      t.timestamps
    end
  end
end
