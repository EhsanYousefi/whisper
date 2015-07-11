class JsonWebToken
  class << self

    def encode(payload, exp = 1.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, load_config['api'], 'HS256')
    end

    def decode(token)
      body = JWT.decode(token, load_config['api'])[0]
      HashWithIndifferentAccess.new body
    rescue
      # we don't need to trow errors, just return nil if JWT is invalid or expired
      nil
    end

    private

    def load_config
      @@config ||= YAML.load_file(App.root.join('config', 'yaml', 'secrets.yml'))[App.environment.to_s]
    end

  end

end