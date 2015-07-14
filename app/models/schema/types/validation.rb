module Schema
  module Types
    module Validation
      class << self

        def create_type(db)
          command = db.execute(

          "CREATE TYPE validation (
            type text,
            presence text,
          );"

          )

          puts command.execution_info.statement.cql
          'OK'
        end

        def drop_type(db)
          command = db.execute(

          "DROP TYPE validation;"

          )

          puts command.execution_info.statement.cql
          'OK'
        end

      end
    end
  end
end