class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :url, null: false, index: {unique: true}
      t.jsonb :linked_data
      t.jsonb :metadata
      t.integer :share_count
      t.string :title
      t.string :slug, index: {unique: true}
      
      t.timestamps
    end
  end
end
