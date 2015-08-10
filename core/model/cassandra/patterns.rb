module Cassandra
  module Custom

    ReservedWords = [
      'desc', 'asc', 'add', 'allow', 'alter','and', 'any', 'apply', 'authorize', 'batch', 'begin', 'by',
      'columnfamily', 'create', 'delete', 'desc', 'drop', 'each_quorum', 'from', 'grant', 'in', 'index', 'inet', 'insert',
      'into', 'keyspace', 'keyspaces', 'limit', 'local_one', 'local_quorum', 'modify', 'norecursive', 'of', 'on', 'one', 'order',
      'password','primary', 'quorum', 'rename', 'revoke', 'schema', 'select', 'set', 'table', 'to', 'token', 'three',
      'truncate', 'two', 'unlogged', 'update', 'use', 'using', 'where', 'with'
    ]

    module TimeSeries

      Types     =  ['integer','float', 'string', 'text', 'array', 'map', 'ip', 'time', 'uuid', 'time_uuid', 'sexy_date']
      Indexable =  ['integer','float', 'string', 'time', 'ip', 'uuid', 'time_uuid']
      Sortable  =  ['integer','float', 'string', 'time', 'uuid', 'time_uuid']
      Defaults  =  ['string', 'float', 'integer', 'text', 'map', 'array', 'ip']


    end

    module Counter

      Types     =  ['integer','float', 'string', 'ip', 'time', 'uuid', 'time_uuid', 'sexy_date']
      Defaults  =  ['string', 'float', 'integer', 'ip']

    end

  end
end
