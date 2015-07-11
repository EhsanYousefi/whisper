class AuthenticateUser
  include Wisper::Publisher

  def execute(email, password, without_pwd = false)

    if without_pwd
      user = User.where(email: email).first
    else
      user = authenticate(email,password)
    end

    return broadcast(:authenticate_user_failed, email) unless user

    broadcast(
      :authenticate_user_successfull,
      JsonWebToken.encode({email: user.email, token: user.auth_token})
    )

  end

  private

  def authenticate(email ,password)
    user = User.where(email: email).first
    return false unless user
    user.authenticate(password)
  end



end