module Cassandra
  module Custom

    class TypeConverter

      # Cassandra Ruby Driver Implicity Supports Hash, Array, Integer, String, Float

      def self.convert(type, obj)

        case
          when type == Inet
            return Cassandra::Types::Inet.new(obj)
          when type == Time
            return Cassandra::Types::Timestamp.new(obj)
          when type == TimeUuid
            return Cassandra::Uuid::Generator.new.now
          when type == Uuid
            return Cassandra::Uuid::Generator.new.uuid
          else
            return obj
        end

      end

    end
  end
end
