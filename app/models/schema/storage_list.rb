module Schema
  module StorageList
    class << self

      def create_column_family(db)
        command = db.execute(

          "CREATE TABLE storage_lists (
            user_name text,
            key text,
            description text,
            PRIMARY KEY ((user_name), key)
          )
          WITH CLUSTERING ORDER BY (key DESC);"

        )

        puts command.execution_info.statement.cql
        'OK'
      end

      def drop_column_family(db)
        command = db.execute(

          "DROP TABLE storage_lists;"

        )

        puts command.execution_info.statement.cql
        'OK'
      end

    end
  end
end
