class String
  include ActiveSupport::Inflector
  include Inet
  include Text

  def blank?
    self.delete(" ").empty?
  end

end