module Cassandra
  module Custom

    class Serializer

      def initialize(object)
        @object = object
      end

      def serialize

        @object.class._columns.each do |name, type|
          @object.send "#{name}=", Cassandra::Custom::TypeConverter.convert( type, @object.send(name) )
        end

        @object

      end

    end

  end
end