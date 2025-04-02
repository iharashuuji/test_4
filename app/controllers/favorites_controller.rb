class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorites = current_user.favorites.new(book_id: book.id)
    favorites.save
    if request.referer&.include?(book_path(book))
      redirect_to book_path(book)

      ## add 以下の内容
    elsif request.referer&.include?(user_path(book.user))
      redirect_to user_path(book.user)
    else
      redirect_to books_path
    end
  end 

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id) 
    if favorite
      favorite.destroy  
    end
    if request.referer&.include?(book_path(book))
      redirect_to book_path(book)
    elsif request.referer&.include?(user_path(book.user))
      redirect_to user_path(book.user) 
    else
      redirect_to books_path
    end
  end
end