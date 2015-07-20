class TypeValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    unless value.nil? || value.kind_of?(type_interpreter(options[:with]))
      record.errors[attribute] << (options[:message] || "is not #{options[:with].inspect.downcase}")
    end

  end

  private

  def type_interpreter(type)
    case
      when type == Time
        return Integer
      else
        type
    end
  end

end
