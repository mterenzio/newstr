class CreateUserSources < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sources do |t|
      t.references :user, index: true, foreign_key: true
      t.references :source, index: true, foreign_key: true

      t.timestamps
    end

    add_index :user_sources, [ :user_id, :source_id ], :unique => true
  end
end
