module Helpers
  module Api

    def post_request(path,body = {},user = nil)
      post(path, body, header(token(user)))
    end

    def get_request(path,body = {},user = nil)
      get(path, body, header(token(user)))
    end

    def put_request(path,body = {},user = nil)
      put(path, body, header(token(user)))
    end

    def delete_request(path,body = {},user = nil)
      delete(path, body, header(token(user)))
    end

    def patch_request(path,body = {},user = nil)
      patch(path, body, header(token(user)))
    end
    # TODO Add More request... like PUT, DELETE

    private
    def header(token = nil)
      return unless token
      { 'CONTENT_TYPE' => 'application/json', 'Token' => token }
    end

    def token(user)
      return unless user
      auth = AuthenticateUser.new

      auth.on(:authenticate_user_successfull) do |token|
        return token
      end

      auth.execute(user.email, nil, true)
    end

  end
end
