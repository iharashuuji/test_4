class UsersController < ApplicationController
before_action :authenticate_user!
  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end
  def show
    @book = Book.new
    @users = User.all

    @user = User.find(params[:id])
    @post_image = Book.new
    if @user == current_user
      @books = Book.where(user: current_user).page(params[:page]).per(5) 
    else
      @books = Book.where(user: @user).page(params[:page]).per(5) 
    end
  end
  def edit
    @book = Book.new
    @user = User.find(params[:id])
    # 自分のユーザ情報を編集しようとしている場合のみ編集ページを表示
    if current_user != @user
      redirect_to user_path(current_user), alert: "You are not authorized to edit this user's information."
    end
  end

  def update
    @book = Book.new

    @user = current_user
    if @user.update(user_params)

      flash[:notice] = "Profile successfully updated."
      redirect_to user_path(@user)
    else
     
      flash[:alert] = "is too short (minimum is 2 characters) error."
      render :edit
    end
  end
  def user_params
    if action_name == "update"
      params.require(:user).permit(:name, :introduction, :profile_image)  # Emailを除外
    else
      params.require(:user).permit(:name, :email, :introduction, :profile_image)  # 新規登録時
    end
  end

end