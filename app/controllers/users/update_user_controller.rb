class UpdateUserController < ApplicationController

  before_start :authorized?

  def main

    update_user = UpdateUser.new

    update_user.on(:update_user_successfull) do |user|

      app.status 202
      return app.json prepare_user_json(user)

    end

    update_user.on(:update_user_failed) do |user|

      app.status 400
      return app.json validation_error: user.errors.to_h

    end

    update_user.on(:update_user_invalid_attributes) do |attributes|

      app.status 400
      return app.json error: 'Invalid Attributes'

    end

    update_user.execute(current_user, app.params)

  end

  private
  def prepare_user_json(user)
    {

      user_name: user.user_name,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      company: user.company

    }
  end

end