class UniqValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    if record.class.where("#{attribute}" => value).first
      record.errors[attribute] << (options[:message] || "already exists")
    end

  end

end