module Schema
  module Types
    module App
      class << self

        def create_type(db)
          command = db.execute(

          "CREATE TYPE app (
            key text,
            structure frozen<map<text, validation>>,
          );"

          )

          puts command.execution_info.statement.cql
          'OK'
        end

        def drop_type(db)
          command = db.execute(

          "DROP TYPE app;"

          )

          puts command.execution_info.statement.cql
          'OK'
        end

      end
    end
  end
end