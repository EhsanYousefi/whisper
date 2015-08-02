module Cassandra
  module Custom
    Types     =  ['integer','float', 'string', 'text', 'array', 'map', 'ip', 'time', 'uuid', 'timeuuid']
    Indexable =  ['integer','float', 'string', 'time', 'ip', 'uuid', 'timeuuid']
    Sortable  =  ['integer','float', 'string', 'time', 'uuid', 'timeuuid']
    Defaults  =  ['string', 'float', 'integer', 'text', 'map', 'array', 'ip']
  end
end
