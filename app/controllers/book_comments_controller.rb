class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(comment_params)
    comment.book_id = book.id
    Rails.logger.debug("Comment params: #{comment_params}") # デバッグ出力

    if comment.save
      flash[:notice] = 'コメントが作成されました！'
    else
      flash[:alert] = 'コメントの作成に失敗しました。'
    end
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.find_by(book_id: book.id) 
    if comment
      comment.destroy  
    end
    redirect_to book_path(book)
  end


  private
  def comment_params
    params.require(:book_comment).permit(:comment)
  end
end
