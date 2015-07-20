module Schema
  module Type
    module Structure
      class << self

        def create_type(db)
          command = db.execute(

            "CREATE TYPE structure (
              type text,
              presence text,
              searchable text
            );"

          )

          puts command.execution_info.statement.cql
          'OK'
        end

        def drop_type(db)
          command = db.execute(

            "DROP TYPE structure;"

          )

          puts command.execution_info.statement.cql
          'OK'
        end

      end
    end
  end
end