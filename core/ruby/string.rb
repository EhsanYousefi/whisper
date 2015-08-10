class String
  include ActiveSupport::Inflector
  include Ip
  include Text

  def blank?
    self.delete(" ").empty?
  end

end
