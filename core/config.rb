module Core
  module Config

    def self.included(target)

      target.set :public_folder, "#{App.root}/whisper-ui"

    end

  end
end

