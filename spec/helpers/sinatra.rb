module Helpers
  module Sinatra
    def app
      App # this defines the active application for this test
    end

    def response
      last_response
    end
  end
end