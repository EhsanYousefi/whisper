module Schema
  module Storage
    class << self

      def create_column_family(db)
        command = db.execute(

          "CREATE TABLE storages (
            email text,
            name text,
            key text,
            column_family_name text,
            structure map<text,frozen<structure>>,
            PRIMARY KEY (email, name, key)
          );"

        )

        puts command.execution_info.statement.cql
        'OK'
      end

      def drop_column_family(db)
        command = db.execute(

          "DROP TABLE storages;"

        )

        puts command.execution_info.statement.cql
        'OK'
      end

    end
  end
end