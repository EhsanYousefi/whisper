module Schema
  module User
    class << self
      def create_column_family(db)
        command = db.execute(

          "CREATE TABLE users (
          email text PRIMARY KEY,
          password text,
          first_name text,
          last_name text,
          company text
        );"

        )

        puts command.execution_info.statement.cql
        'OK'
      end

      def drop_column_family(db)
        command = db.execute(

          "DROP TABLE users;"

        )

        puts command.execution_info.statement.cql
        'OK'
      end

    end
  end
end