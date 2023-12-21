class CreateSourceArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :source_articles do |t|
      t.references :source, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true
      t.jsonb :note
      t.boolean :is_repost, default: false, null: false

      t.timestamps
    end

    add_index :source_articles, [ :source_id, :article_id ], :unique => true
  end
end
