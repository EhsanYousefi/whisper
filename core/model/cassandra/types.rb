module Cassandra
  module Custom
    Types     =  ['integer', 'string', 'text', 'array', 'map', 'ip', 'time', 'uuid', 'timeuuid']
    Indexable =  ['integer', 'string', 'time', 'ip', 'uuid', 'timeuuid']
    Sortable  =  ['integer', 'string', 'time', 'uuid', 'timeuuid']
    Defaults  =  ['string', 'integer', 'text', 'float', 'map', 'array', 'ip']
  end
end