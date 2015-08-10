class ErrSerializer

  def self.serialize(errors)
    return if errors.nil?

    errors.messages.map do |k, v|
      v.map do |msg|
        { id: k, title: msg }
      end
    end.flatten

  end

end
