class CreateUserController < ApplicationController

  def main
    create_user = CreateUser.new

    create_user.on(:create_user_successful) do |user|

      return app.json(
          email: user.email,
          auth_token: user.auth_token,
          first_name: user.first_name,
          last_name: user.last_name,
          company: user.company
      )

    end

    create_user.on(:create_user_failed) do |user|

      return app.json validation_error: user.errors.to_h

    end

    create_user.execute(app.params[:user])

  end

end