class InetValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    begin
      IPAddr.new value
    rescue
      record.errors[attribute] << (options[:message] || "is not valid")
    end

  end

end