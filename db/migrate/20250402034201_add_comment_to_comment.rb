class AddCommentToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :comment, :integer
  end
end
