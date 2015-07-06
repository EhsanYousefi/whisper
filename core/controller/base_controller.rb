class BaseController
  attr_reader :app

  @@before_start = []
  @@on_finish = []

  def self.construct(arg)
    self.new(arg).response
  end

  def initialize(app)
    app.set_instance
    @app ||= app
  end

  def self.before_start(*args)
    @@before_start = args
  end

  def self.on_finish(*args)
    @@on_finish = args
  end

  def main
    base.erb "<h3>You should define `call` instance method on your controller class!</h3>"
  end


  def response
    send_chain @@before_start
    call_var = main
    return call_var if @@on_finish.empty?
    send_chain @@on_finish
  end

  private
  def send_chain(arr)
    arr.inject(self) {|o, a| o.send(a) }
  end

end