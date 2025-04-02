Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  get "home/about" => "homes#about", as: "about"
  resources :users, only: [:show, :edit, :index, :update]
  resources :books, only: [:new, :create, :index, :show, :destroy,:edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end

# 今から導入を行うのは、いいね機能！　これは投稿と１対Nの関係になっている
