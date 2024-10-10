class BlogPost < ActiveRecord::Migration[8.0]
  def change
    create_table :blog_posts, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps null: false
      t.string :title, null: false
      t.text :body, null: false
      t.date :published_at
      t.string :image
      t.string :slug
    end
    add_index :blog_posts, :published_at
    add_index :blog_posts, :slug, unique: true
  end
end
