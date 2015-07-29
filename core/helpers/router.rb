module Core
  module Helpers
    module Router

      def controller(ctrl_class)
        self.response["Access-Control-Allow-Headers"] = "origin, x-requested-with, content-type"
        self.response["Access-Control-Allow-Origin"] = '*'
        ctrl_class.construct self
      end

    end

  end
end
