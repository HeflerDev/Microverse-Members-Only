class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in(user)
      redirect_to(root_path)
      flash[:success] = 'Access Granted'
    else
      flash.now[:warning] = 'Access Denied'
      render 'new'
    end
  end

  def home
    @user = current_user
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
