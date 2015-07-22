class CassandraTypeMapper

  VALID_TYPES = {

    'string'    => 'text',
    'integer'   => 'varint',
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
