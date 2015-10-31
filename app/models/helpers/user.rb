module Helpers
  module User

    def generate_auth_token
      SecureRandom.uuid
    end

  end
end