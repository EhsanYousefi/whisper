module Cassandra

  module Custom

    class Serializer

      def initialize(action, object)

        @action = action
        @object = object

      end

      def serialize

        @object.class._columns.each do |name, type|
          @object.send "#{name}=", Cassandra::Custom::TypeConverter.convert( @action, type[:type], @object.send(name) )
        end

        @object

      end

    end

  end

end
