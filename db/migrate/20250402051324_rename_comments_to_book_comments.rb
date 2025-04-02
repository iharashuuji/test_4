class RenameCommentsToBookComments < ActiveRecord::Migration[6.1]
  def change
    rename_table :comments, :book_comments
  end
end
