class String
  include ActiveSupport::Inflector

  def blank?
    self.delete(" ").empty?
  end

end