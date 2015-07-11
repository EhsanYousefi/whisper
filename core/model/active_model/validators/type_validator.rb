class TypeValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    unless value.nil? || value.kind_of?(options[:with])
      record.errors[attribute] << (options[:message] || "is not #{options[:with].inspect.downcase}")
    end

  end

end