class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.new
  end
  def create
    @book = Book.new(post_image_params)
    @book.user_id = current_user.id

    
    if @book.save
      
      flash[:notice] = "Book successfully posted"
      redirect_to book_path(@book) # redirect_to showならshowアクション内のインスタンス変数を用いれる。
    else
      @books = Book.includes(:user).page(params[:page]).per(5)
      @book.title = ""
      @user = current_user
      @bookss = Book.new
      render :index # renderは、ビューに飛ばすだけで、
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(post_image_params)
      flash[:notice] = "Book successfully updated."
      redirect_to book_path(@book)
    else
      flash[:alert] = "Book update error."
      render :edit
    end
  end
  def index
    @user = current_user
    @books = Book.includes(:user).page(params[:page])
    @bookss = Book.new
    Rails.logger.debug "DEBUG: @book = #{@book.inspect}"
  end
  def show
    @book = Book.find(params[:id])
    @bookss = Book.new
    @user = @book.user
    @books = @user.books.page(params[:page])
    @comment = BookComment.new
  end
  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path
      @books = Book.all
    else
      @books = Book.all
      render :index
    end
  end
  def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path, alert: "Error : You are not authorized to edit this user's information."
    end
  end
  private

  def post_image_params
    params.require(:book).permit(:title, :body)
  end
end
