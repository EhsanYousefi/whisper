module Schema
  module User
    class << self
      def create_column_family(db)
        command = db.execute(

          "CREATE TABLE users (
            email text,
            auth_token text,
            password_digest text,
            first_name text,
            last_name text,
            company text,
            PRIMARY KEY (email,auth_token)
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