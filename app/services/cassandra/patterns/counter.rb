module Cassandra
  module Patterns

    class Metrics

      def self.create_storage_successful(storage)

        storage = self.prepare_storage(storage)

        App.database.execute(
          "CREATE TABLE #{storage['column_family_name']} (
            #{
              self.prepare_table_info(
                self.extract_column_names_and_types(storage['structure']),
                self.prepare_primary_key(storage['structure'])
              )
            }
          )
          #{prepare_clustering_order(storage)};"
        )

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

      def self.prepare_primary_key(storage)
        "PRIMARY KEY (#{(storage.keys - ['ct']).join(',')})"
      end

      def self.prepare_clustering_order(storage)
        "WITH CLUSTERING ORDER BY (#{storage['sort_by'].downcase} #{storage['sort'].upcase})"
      end

      def self.prepare_table_info(columns, primary_key)
        columns + primary_key
      end

    end

  end
end
