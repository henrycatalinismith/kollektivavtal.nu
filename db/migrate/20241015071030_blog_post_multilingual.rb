class BlogPostMultilingual < ActiveRecord::Migration[8.0]
  def change
    rename_column :blog_posts, :title, :title_en
    rename_column :blog_posts, :body, :body_en
    add_column :blog_posts, :title_sv, :string
    add_column :blog_posts, :body_sv, :string
  end
end
