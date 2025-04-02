class ChangeCommentTypeInComments < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :comment, :text
  end
end
