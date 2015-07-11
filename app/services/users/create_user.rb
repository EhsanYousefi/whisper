class CreateUser
  include Wisper::Publisher

  def execute(attributes)

    user = User.new(attributes)
    user.auth_token = user.generate_auth_token

    if user.create
      broadcast(:create_user_successful, user)
    else
      broadcast(:create_user_failed,     user)
    end

  end

end