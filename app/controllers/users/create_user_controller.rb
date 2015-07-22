class CreateUserController < ApplicationController

  def main
    create_user = CreateUser.new

    create_user.on(:create_user_successful) do |user|

      auth_token = ''

      # Authorize User
      auth_user = AuthenticateUser.new
      auth_user.on(:authenticate_user_successfull) do |token|
        auth_token = token
      end
      auth_user.execute(user.user_name, nil, true)

      app.status 201
      return app.json(
          user_name: user.user_name,
          email: user.email,
          token: auth_token,
          first_name: user.first_name,
          last_name: user.last_name,
          company: user.company
      )

    end

    create_user.on(:create_user_failed) do |user|

      app.status 400
      return app.json validation_error: user.errors.to_h

    end

    create_user.execute(app.params)

  end

end
