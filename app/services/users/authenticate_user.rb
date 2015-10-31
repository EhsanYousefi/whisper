class AuthenticateUser
  include Wisper::Publisher

  def execute(user_name, password, without_pwd = false)

    if without_pwd
      user = User.where(user_name: user_name).first
    else
      user = authenticate(user_name,password)
    end

    return broadcast(:authenticate_user_failed, user_name) unless user

    broadcast(
      :authenticate_user_successfull,
      JsonWebToken.encode({user_name: user.user_name, token: user.auth_token})
    )

  end

  private

  def authenticate(user_name ,password)
    user = User.where(user_name: user_name).first
    return false unless user
    user.authenticate(password)
  end



end
