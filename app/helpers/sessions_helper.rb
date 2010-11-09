module SessionsHelper
  def login(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user= user
  end

  def current_user= (user)
    @current_user = user
  end

  def current_user
    # ||= assigns user_from_remember_token to @current_user only if
    # @current_user isn't already assigned. Otherwise @current_user
    # is returned directly
    @current_user ||= user_from_remember_token
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    cookies.delete(:remember_token)
    current_user = nil
  end

  private

    def user_from_remember_token
      # * operator extracts arguments from array, e.g. *[a,b] returs a, b
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

end

