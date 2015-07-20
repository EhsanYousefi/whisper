class UniqValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    return unless record.changes[attribute.to_s]
    if record.class.where("#{attribute}" => value).first
      record.errors[attribute] << (options[:message] || "already exists")
    end

  end

end