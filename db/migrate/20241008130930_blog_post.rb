class BlogPost < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_posts, id: false do |t|
      t.primary_key :id, :string, default: -> { "ULID()" }
      t.timestamps null: false
      t.string :title, null: false
      t.text :body, null: false
      t.date :published_at
    end
    add_index :blog_posts, :published_at
  end
end
