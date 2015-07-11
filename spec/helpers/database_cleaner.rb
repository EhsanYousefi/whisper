module Helpers
  module Cassandra
    def clean_database(*class_names)
      class_names.each do |c|
        App.database.execute("TRUNCATE #{c.underscore.pluralize};")
      end
    end
  end
end