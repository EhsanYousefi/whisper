class CreateUser
  include Wisper::Publisher

  def execute(attributes)

    # Prevent From Mass Assignment
    user = User.new(
      email:                  attributes[:email],
      password:               attributes[:password],
      password_confirmation:  attributes[:password_confirmation],
      first_name:             attributes[:first_name],
      last_name:              attributes[:last_name],
      company:                attributes[:company]
    )

    user.auth_token = user.generate_auth_token

    if user.create
      broadcast(:create_user_successful, user)
    else
      broadcast(:create_user_failed,     user)
    end

  end

end