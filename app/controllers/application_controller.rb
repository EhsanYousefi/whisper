class ApplicationController < BaseController

  def authorized?
    auth = AuthorizeUser.new

    auth.on(:authorization_user_successfull) do |token|
      @current_user = User.where(email: token[:email]).first
      return true
    end

    auth.on(:authorization_user_failed) do |token|
      return app.halt 401, {error: 'Unauthorized'}.to_json
      # return app.json error: 'Unauthorized'
    end

    auth.execute(app.env['HTTP_TOKEN'])
  end

  def current_user
    @current_user
  end

end