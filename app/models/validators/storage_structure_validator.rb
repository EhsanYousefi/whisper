class StorageStructureValidator

  attr_reader :errors
  BOOLEAN_TYPES = ['true', 'false', nil]

  def initialize(struct)
    @struct = struct.with_indifferent_access
    @errors = []
  end


  def valid?

    validate_mandatory_fields
    validate_type               if errors.empty?
    validate_required           if errors.empty?
    validate_index              if errors.empty?
    validate_index_with_type    if errors.empty?
    validate_index_count        if errors.empty?
    validate_default_with_type  if errors.empty?
    validate_default            if errors.empty?

    errors.empty?

  end

  def validate_mandatory_fields

    validate = @struct.map do |k,v|
      !v['type'].blank?
    end

    errors << "structure -> `[presence, type]` is mandatory" if validate.include? false

  end

  def validate_type

    validate = @struct.map do |k,v|
      Cassandra::Custom::Types.include? v['type']
    end

    errors << "structure -> `type` should be one of #{Cassandra::Custom::Types.inspect}" if validate.include? false

  end

  def validate_required

    validate = @struct.map do |k,v|
      BOOLEAN_TYPES.include? v['required']
    end

    errors << "structure -> `required` should be one of #{['true', 'false'].inspect}" if validate.include? false

  end

  def validate_index

    validate = @struct.map do |k,v|
      BOOLEAN_TYPES.include? v['index']
    end

    errors << "structure -> `index` should be one of #{['true', 'false'].inspect}" if validate.include? false

  end

  def validate_index_with_type

    o = nil
    validate = @struct.map do |k,v|

      if v['index'] == 'true' and !Cassandra::Custom::Indexable.include?(v['type'])
        o = v['type']
        false
      else
        true
      end

    end

    errors << "structure -> `index` could not be used with `#{o}` type" if validate.include? false

  end

  def validate_index_count
    count = 1

    validate = @struct.map do |k,v|
      v['index'] == 'true'
    end

    errors << "structure -> `index` could not be used more than #{count} times" if (validate - [false]).count > 1

  end

  # def validate_sort
  #
  #   validate = @struct.map do |s|
  #     BOOLEAN_TYPES.include? h.last.to_h['sort']
  #   end
  #
  #   errors << "structure -> `sort` should be one of #{BOOLEAN_TYPES.inspect}" if validate.include? false
  #
  # end

  # def validate_sort_with_type
  #
  #   o = ''
  #   validate = @struct.map do |s|
  #     o = h.last.to_h
  #     if o['sort'] == 'true' and !Cassandra::Custom::Sortable.include?(o['type'])
  #       false
  #     else
  #       true
  #     end
  #   end
  #
  #   errors << "structure -> `sort` could not be used with `#{o['type']}` type" if validate.include? false
  #
  # end

  # def validate_sort_count
  #
  #   count = 2
  #
  #   validate = @struct.map do |s|
  #     h.last.to_h['sort'] == 'true'
  #   end
  #
  #   errors << "structure -> `sort` could not be used more than #{count} times" if (validate - [false]).count > 1
  #
  # end

  def validate_default_with_type

    o = ''
    validate = @struct.map do |s|
      o = h.last.to_h
      if o['default'] != nil and !Cassandra::Custom::Defaults.include?(o['type'])
        false
      else
        true
      end
    end

    errors << "structure -> `default` could not be used with `#{o['type']}` type" if validate.include? false

  end

  def validate_default

    validate = @struct.map do |s|
      o = h.last.to_h

      if o['default']

        return send("validate_default_type_#{o['type']}", o['default'])

      end


      o = h.last.to_h
      !o['default'].nil? and o['default'].kind_of? Cassandra::Custom::Mapper.get_type(o['type'])
    end

    errors << "structure -> `default` could not be matched with `type`" if validate.include? false

  end

  def validate_default_type_map(val)
    return errors << "structure -> `default` could not be matched with `type`" unless val.kind_of?(Hash)

    validate = val.map do |k,v|
      return false unless v.kind_of?(String) # We only accept Map with this condition Map<text, text>
      true
    end

    errors << "structure -> `default` with `map` type could be string in both directions like: {'key': 'value' }" if validate.include?(false)
  end

  def validate_default_type_array(val)

    return errors << "structure -> `default` could be matched with `type`" unless val.kind_of?(Array)

    validate = val.map do |k,v|
      return false unless v.kind_of?(String) # We only accept Map with this condition Map<text, text>
      true
    end

    errors << "structure -> `default` with `array` type could only contain string like: ['string', 'string']" if validate.include?(false)

  end

  def validate_default_type_string(val)
    errors << "structure -> `default` with `string` type could be string but is not" unless val.kind_of?(String)
  end

  def validate_default_type_text(val)
    errors << "structure -> `default` with `text` type could be string but is not" unless val.kind_of?(String)
  end

  def validate_default_type_integer(val)
    errors << "structure -> `default` with `integer` type could be integer but is not" unless val.kind_of?(Integer)
  end

  def validate_default_type_ip(val)
    begin
      IPAddr.new val
    end
    errors << "structure -> `default` with `ip` type have invalid value"
  end
end