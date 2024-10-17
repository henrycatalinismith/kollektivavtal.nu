class RemovePostImage < ActiveRecord::Migration[8.0]
  def change
    remove_column :blog_posts, :image
  end
end
