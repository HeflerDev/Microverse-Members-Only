class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  def new
    @post = Post.new
  end

  def create
    @posts = Post.new(posts_params)
    @posts.user_id = session[:user_id]
    if @posts.save
      redirect_to posts_url
    else
      flash[:warning] = "Access Denied"
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private
  def posts_params
    params.require(:post).permit(:body)
  end

  def logged_in_user
    unless logged_in?
      
      redirect_to(login_path)
      flash[:danger] = 'Please log in'
    end
  end
end
