module Cassandra
  module Custom
    class Mapper

      VALID_TYPES = {

        'string'    => 'text',
        'text'      => 'text',
        'integer'   => 'varint',
        'map'       => 'map',
        'array'     => 'array',
        'float'     => 'float',
        'time'      => 'timestamp',
        'inet'      => 'inet',
        'uuid'      => 'uuid',
        'timeuuid'  => 'timeuuid'

      }

      def self.get_type(type)
        VALID_TYPES[type.downcase]
      end

    end

  end
end