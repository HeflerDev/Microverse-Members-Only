module SessionsHelper
  def log_in(user)
    remember_digest = User.digest(User.new_token)
    user.update_attribute(:remember_digest, remember_digest)
    cookies.permanent[:remember_token] = remember_digest
  end

  def current_user
    @current_user ||= User.find_by(remember_digest: cookies.permanent[:remember_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget
    session.delete(:user_id)
    @current_user = nil
  end
end
