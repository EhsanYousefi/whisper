class CreateApp
  include Wisper::Publisher

  def execute(user, attributes)

    # Prevent From Mass Assignment
    validator = AppValidator.new(attributes)

    if validator.valid?
      # Merge New App to current user apps
      user.apps.merge(attributes)

      if user.update_by(email: user.email)
        broadcast(:create_app_successfull, user)
      else
        broadcast(:create_app_failed, user)
      end

    else
      broadcast(:create_app_failed, validator)
    end

  end

end