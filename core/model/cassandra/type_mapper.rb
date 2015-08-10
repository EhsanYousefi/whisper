module Cassandra
  module Custom
    class TypeMapper

      VALID_TYPES = {

        'string'    => 'text',
        'text'      => 'text',
        'integer'   => 'varint',
        'map'       => 'map',
        'array'     => 'array',
        'float'     => 'float',
        'time'      => 'timestamp',
        'ip'        => 'inet',
        'uuid'      => 'uuid',
        'time_uuid' => 'timeuuid',
        'sexy_date' => 'varint'

      }

      def self.get_type(type)
        VALID_TYPES[type.downcase]
      end

    end

  end
end
