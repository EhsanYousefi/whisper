module StorageStructure
  module Counter
    class Validator
      attr_reader :errors
      BOOLEAN_TYPES = [true, false, nil]

      def initialize(struct)
        @struct = struct.with_indifferent_access
        @errors = []
      end


      def valid?

        validate_mandatory_fields
        validate_reserver_words         if errors.empty?
        validate_type                   if errors.empty?
        validate_required               if errors.empty?
        validate_index                  if errors.empty?
        validate_sort_count             if errors.empty?
        validate_sort                   if errors.empty?
        validate_default_with_type      if errors.empty?
        validate_default_with_required  if errors.empty?
        validate_default                if errors.empty?

        errors.empty?

      end

      def validate_mandatory_fields

        validate = @struct.map do |k,v|
          !v['type'].blank?
        end

        errors << "structure -> `[type]` is mandatory" if validate.include? false

      end

      def validate_reserver_words
        word = nil

        validate = @struct.map do |k,v|
          if Cassandra::Custom::ReservedWords.include?(k.to_s)
            word = k
            false
          else
            true
          end
        end

        errors << "structure -> `#{word}` key, is reserved by our database please use another key" if validate.include? false

      end

      def validate_type

        validate = @struct.map do |k,v|
          Cassandra::Custom::TimeSeries::Types.include?(v['type'])
        end

        errors << "structure -> `type` should be one of #{Cassandra::Custom::TimeSeries::Types.inspect}" if validate.include? false

      end

      def validate_required

        validate = @struct.map do |k,v|
          v['required'] == true
        end

        errors << "structure -> `required` should be one of #{[true].inspect}" if validate.include? false

      end

      def validate_index

        validate = @struct.map do |k,v|
          v['index'] == true
        end

        errors << "structure -> `index` should be one of #{[true].inspect}" if validate.include? false

      end

      def validate_sort_count

        count = 1

        validate = @struct.map do |k,v|
          !v['sort_by'].blank?
        end

        errors << "structure -> `sort_by` could not be used more than #{count} times" if (validate - [false]).count > 1

      end


      def validate_sort

        validate = @struct.map do |k,v|
          @struct.keys.include? v['sort_by']
        end

        errors << "structure -> `sort_by` should be one of #{@struct.keys.inspect}" if validate.include? false

      end



      def validate_default_with_type

        o = nil
        validate = @struct.map do |k,v|
          if v['default'] != nil and !Cassandra::Custom::Counter::Defaults.include?(v['type'])
            o = v['type']
            false
          else
            true
          end
        end

        errors << "structure -> `default` could not be used with `#{o}` type" if validate.include? false

      end

      def validate_default_with_required

        validate = @struct.map do |k,v|
          if v['default'] and v['required'] == true
            false
          else
            true
          end
        end

        errors << "structure -> `default` could not be used with `required: true`" if validate.include? false

      end


      def validate_default

        validate = @struct.map do |k,v|

          if v['default']

            send("validate_default_type_#{v['type']}", v['default'])

          end


          # !v['default'].nil? and o['default'].kind_of? Cassandra::Custom::TypeMapper.get_type(v['type'])
        end

        # errors << "structure -> `default` could be matched with `type`" if validate.include? false

      end



      def validate_default_type_string(val)
        unless val.kind_of?(String)
          errors << "structure -> `default` with `string` type could be string but is not"
          return false
        else
          true
        end
      end


      def validate_default_type_integer(val)
        unless val.kind_of?(Integer)
          errors << "structure -> `default` with `integer` type could be integer but is not"
          return false
        else
          true
        end
      end

      def validate_default_type_float(val)
        unless val.kind_of?(Float)
          errors << "structure -> `default` with `float` type could be float but is not"
          return false
        else
          true
        end
      end


      def validate_default_type_ip(val)
        begin
          IPAddr.new val
        rescue
          errors << "structure -> `default` with `ip` type have invalid value"
          return false
        end
        true
      end

    end
  end
end
