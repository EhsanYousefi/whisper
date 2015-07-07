class HomeController < ApplicationController

  def main

    user = User.where(email: 'hossein.yousefi@live.com').first
    app.json user.as_json

  end

end