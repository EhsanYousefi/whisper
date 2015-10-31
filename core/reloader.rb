module Core::Reloader

  def self.included(target)
    if target.development?

      target.configure :development do
        target.register Sinatra::Reloader

        target.also_reload target.root.join('config', '*.rb')
        target.also_reload target.root.join('config','**','*.rb')
        target.also_reload target.root.join('app','**','*.rb')
        target.also_reload target.root.join('core','*.rb')
        target.also_reload target.root.join('core','**','*.rb')
        target.also_reload target.root.join('lib', '*.rb')
        target.also_reload target.root.join('lib','**','*.rb')

      end

    end
  end

end
