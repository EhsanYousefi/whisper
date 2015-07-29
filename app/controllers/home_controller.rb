class HomeController < ApplicationController

  # before_start :authorized?

  def main

    app.json name: 'hello'

  end

end
