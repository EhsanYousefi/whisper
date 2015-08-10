class BaseController

  attr_reader :app

  class << self; attr_accessor :_before_start, :_on_finish end

  def self.construct(arg)
    self.new(arg).response
  end

  def initialize(app)
    app.set_instance
    @app ||= app
  end

  def self.before_start(*args)
    self._before_start = args
  end

  def self.on_finish(*args)
    self._on_finish = args
  end

  def main
    app.erb "<h3>You should define `call` instance method on your controller class!</h3>"
  end


  def response
    send_chain self.class._before_start unless self.class._before_start.blank?
    call_var = main
    return call_var if self.class._on_finish.blank?
    send_chain self.class._on_finish
  end

  private
  def send_chain(arr)
    arr.inject(self) {|o, a| o.send(a) }
  end

end
