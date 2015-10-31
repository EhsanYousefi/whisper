class UniqWithValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)

    attributes = {}
    option = options[:with] || options[:in]

    if options[:in]

      option.push attribute

      option.each do |k|
        attributes[k] = record.send(k)
      end

    else

      option = [attribute, option]

      option.each do |k|
        attributes[k] = record.send(k)
      end

    end

    count = record.changes.count
    return if (record.changes.keys.map(&:to_sym) - option.map(&:to_sym)).count == count

    if record.class.where(attributes).first
      record.errors[attribute] << (options[:message] || "already exists")
    end

  end

end