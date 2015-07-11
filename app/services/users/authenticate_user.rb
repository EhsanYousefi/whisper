class AuthenticateUser
  include Wisper::Publisher

  def execute(email, password)
    user = authenticate(email,password)

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