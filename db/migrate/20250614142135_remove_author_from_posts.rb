class RemoveAuthorFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :author, :string
  end
end
