class TypeValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if value.nil?

    if options[:with] == Time

      begin

        if value.kind_of? String
          t = Time.parse(value)
          # Implicity Change field value(Make it Cql-rb Compatible)
          record.send("#{attribute}=", t)
        else
          t = Time.at(value)
          # Implicity Change field value
          record.send("#{attribute}=", t)
        end

      rescue
        record.errors[attribute] << (options[:message] || "is not #{options[:with].inspect.downcase}")
      ensure
        return
      end

    end

    unless value.nil? || value.kind_of?(options[:with])
      record.errors[attribute] << (options[:message] || "is not #{options[:with].inspect.downcase}")
    end

  end

end
