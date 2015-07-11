class AuthorizeUser
  include Wisper::Publisher

  def execute(token)
    auth = authorize(token)
    return broadcast(:authorization_user_failed, token) if auth.blank?

    broadcast(:authorization_user_successfull, auth)
  end

  private

  def authorize(token)
    JsonWebToken.decode(token)
  end

end