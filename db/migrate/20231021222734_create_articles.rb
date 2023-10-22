class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :url, null: false, unique: true
      t.jsonb :linked_data
      t.jsonb :metadata
      t.integer :share_count
      t.string :title
      t.string :slug, null: false, unique: true
      
      t.timestamps
    end
  end
end
