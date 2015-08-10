class TypeValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    return if value.nil?
    send("_#{options[:with]}", record, attribute, value )

  end

  def _Time(record, attribute, value)

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

  def _String(record, attribute, value)

    unless value.kind_of?(String) and value.length < 256
      record.errors[attribute] << (options[:message] || "is not #{options[:with].inspect.downcase}")
    end

  end

  def method_missing(obj, *args, &block)

    unless args[2].kind_of?(options[:with])
      args[0].errors[args[1]] << (options[:message] || "is not #{options[:with].inspect.downcase}")
    end

  end

end
