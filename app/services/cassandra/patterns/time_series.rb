module Cassandra
  module Patterns

    class TimeSeries

      def self.create_storage_successful(storage)

        storage = self.prepare_storage(storage)

        App.database.execute(
          "CREATE TABLE #{storage['column_family_name']} (
            #{
              self.prepare_table_info(
                self.extract_column_names_and_types(storage['structure']),
                self.prepare_primary_key
              )
            }
          )
          #{prepare_clustering_order(storage)};"
        )

        self.prepare_indexes(storage).each do |i|
          App.database.execute i
        end

      end

      private

      def self.prepare_storage(storage)
        storage = storage.to_h
        storage['structure'] = JSON.parse(storage['structure'])
        storage
      end

      def self.extract_column_names_and_types(structure)

        structure.map do |k,v|
          "#{k} #{Cassandra::Custom::TypeMapper.get_type(v.to_h['type'])},"
        end.join('')

      end

      def self.prepare_indexes(storage)

        storage['structure'].map do |k,v|
          "CREATE INDEX ON #{storage['column_family_name']} (#{k})" if v.to_h['index'] == true
        end.compact

      end

      def self.prepare_primary_key
        'PRIMARY KEY ((ca), id)'
      end

      def self.prepare_clustering_order(storage)
        "WITH CLUSTERING ORDER BY (id #{storage['sort'].upcase})"
      end

      def self.prepare_table_info(columns, primary_key)
        columns + primary_key
      end

    end

  end
end
