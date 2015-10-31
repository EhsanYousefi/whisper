class CreateAppController < ApplicationController

  before_start :authorized?

  def main

    current_apps = @current_user.apps

    @current_user.update_by email: @current_user.email

  end

end