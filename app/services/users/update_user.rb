class UpdateUser
  include Wisper::Publisher

  def execute(user, attributes)

    begin
      user.assign_attributes(prepare_attributes(attributes))
    rescue
      return broadcast(:update_user_invalid_attributes, attributes)
    end

    if user.update_where(user_name: user.user_name, auth_token: user.auth_token)
      broadcast(:update_user_successfull, user)
    else
      broadcast(:update_user_failed, user)
    end

  end

  private
  def prepare_attributes(attrs)
    attrs.delete :user_name
    raise ArgumentError if attrs.blank?
    attrs
  end

end
