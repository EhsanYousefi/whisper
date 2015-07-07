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
    columns = self.class.columns.map {|c| "@#{c.to_s}" }
    Hash[columns.map { |v| [v.to_s[1..-1].to_sym, instance_variable_get(v)] }].with_indifferent_access
  end

  alias_method :to_h, :attributes

  def attributes=(hash)

    hash.each do |key, value|
      raise InvalidColumnError.new("Invalid column: #{key.to_s}") unless self.class.columns.include?(key.to_sym)
      # instance_variable_set("@#{key}", value)
      send("#{key}=", value)
    end

  end

  def assign_attributes(hash= {})
    attributes.stringify_keys.merge!(hash)
    self.attributes = attributes.merge!(hash.stringify_keys)
  end



  module ClassMethods

    def columns(*array)
      begin
        @@columns
      rescue
        @@columns = array.map &:to_sym

        @@columns.each do |a|

          a_write = "#{a}="

          # Define setter method ActiveSupport::Drity Compatible
          define_method(a_write) do |val|
            send("#{a.to_s}_will_change!") unless val == instance_variable_get("@#{a}")
            instance_variable_set("@#{a}", val)
          end

          # Define getter method ActiveSupport::Drity Compatible
          define_method(a) do
            instance_variable_get("@#{a}")
          end

        end

        @@columns
      end
    end

    def column_family_name
      self.to_s.downcase.pluralize
    end

    def database
      App.get_instance.database
    end

    def where(hash={},options={})
      raise ArgumentError if hash.empty?
      options = options.with_indifferent_access

      query = self.select_query(
        self.database,
        self.column_family_name,
        hash.stringify_keys,
        options[:order_by],
        options[:order_type],
        options[:limit])

      query.map do |row|
        new = self.new(row)
        new.send(:persist!)
        new
      end
    end

  end

end