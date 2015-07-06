module Core
  module Helpers
    module Router

      def controller(ctrl_class)
        ctrl_class.construct self
      end

    end

  end
end