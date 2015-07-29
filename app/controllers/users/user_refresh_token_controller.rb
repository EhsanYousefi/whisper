class UserRefreshTokenController < ApplicationController

  before_start :authorized?

  def main

    auth_user = AuthenticateUser.new

    auth_user.on(:authenticate_user_successfull) do |token|

      app.status 200
      return app.json(token: token)

    end

    auth_user.on(:authenticate_user_failed) do |user_name|

      app.status 401
      return app.json error: "Authentication Failed"

    end

    auth_user.execute(current_user.user_name, nil, true)

  end

end
