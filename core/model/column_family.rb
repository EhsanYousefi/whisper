module Cassandra::ColumnFamily

  class InvalidColumnError < StandardError
    def initialize(msg = "Invalid Columns")
      super
    end
  end

  def self.included(target)

    target.include ActiveModel::AttributeMethods
    target.include ActiveModel::Dirty
    target.include ActiveModel::Model
    target.include ActiveModel::Serializers::JSON
    target.include ::Cassandra::Persistence

    target.extend ClassMethods
    target.extend Cassandra::QueryBuilder

  end

  def attributes
    columns = self.class._columns.map {|k,v| k }
    Hash[columns.map { |v| [v, send(v) ] }].with_indifferent_access
  end

  alias_method :to_h, :attributes

  def attributes=(hash)

    hash.each do |key, value|
      raise InvalidColumnError.new("Invalid column: #{key.to_s}") unless self.class._columns.include?(key.to_sym)
      # instance_variable_set("@#{key}", value)
      send("#{key}=", value)
    end

  end

  def assign_attributes(hash= {})
    attributes.stringify_keys.merge!(hash)
    self.attributes = attributes.merge!(hash.stringify_keys)
  end

  module ClassMethods

    attr_accessor :_columns;
    attr_accessor :_column_family_name

    def columns(hash={})

      if self._columns
        self._columns
      else
        self._columns = hash.symbolize_keys

        self._columns.each do |k,v|

          v = v.with_indifferent_access

          a_write = "#{k}="

          # Define setter method ActiveSupport::Drity Compatible
          define_method(a_write) do |val|
            send("#{k.to_s}_will_change!") unless val == instance_variable_get("@#{k}")
            instance_variable_set("@#{k}", val)
          end

          # Define getter method ActiveSupport::Drity Compatible
          define_method(k) do
            instance_variable_get("@#{k}") || v[:default]
          end

          send(:validates, k, { type: v[:type] })

        end

        self._columns
      end
    end

    def column_family_name
      self._column_family_name || self.to_s.underscore.pluralize
    end

    def database
      App.database
    end

    def where(hash={},options={})
      raise ArgumentError if hash.empty?
      options = options.with_indifferent_access

      begin
        query = self.select_query(
          self.database,
          self.column_family_name,
          hash.stringify_keys,
          options[:order_by],
          options[:order_type],
          options[:limit]
        )
      rescue
        return []
      end

      query.map do |row|
        new = self.new(row)
        new.send(:persist!); new.send(:changes_applied)
        new
      end
    end

    def all

      begin
        query = self.select_all_query(self.database, self.column_family_name)
      rescue
        return []
      end

      query.map do |row|
        new = self.new(row)
        new.send(:persist!); new.send(:changes_applied)
        new
      end

    end

  end

end
