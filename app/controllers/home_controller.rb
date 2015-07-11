class HomeController < ApplicationController

  before_start :authorized?

  def main

    user = User.where(email: 'hossein.yousefi@live.com').first
    app.json user.as_json

  end

end