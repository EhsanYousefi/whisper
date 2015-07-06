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

    target.extend ClassMethods

  end

  def column_family_name
    self.class.to_s.downcase.pluralize
  end

  def attributes
    columns = self.class.columns.map {|c| "@#{c.to_s}" }
    Hash[columns.map { |v| [v.to_s[1..-1].to_sym, instance_variable_get(v)] }].with_indifferent_access
  end

  alias_method :to_h, :attributes

  def attributes=(hash)

    hash.each do |key, value|
      raise InvalidColumnError.new("Invalid column: #{key.to_s}") unless self.class.columns.include?(key.to_sym)
      instance_variable_set("@#{key}", value)
    end

  end

  def assign_attributes(hash= {})
    attributes.stringify_keys.merge!(hash)
    self.attributes = attributes.merge!(hash.stringify_keys)
  end

  def database
    App.get_instance.database
  end


  def save
    return false unless valid?
    hash = self.to_h.compact

    begin

      self.database.execute(
        "INSERT INTO #{self.column_family_name}
          (#{hash.keys.join(',')}) VALUES (#{conversion(hash.values).join(',')});"
      )

      true
    rescue
      false
    end

  end

  # x.update_attributes

  def conversion(array)
    array.map do |el|
      if el.kind_of?(String)
        "'" + el + "'"
      else
        el
      end
    end
  end

  module ClassMethods

    def columns(*array)
      begin
        @@columns
      rescue
        @@columns = array.map &:to_sym

        @@columns.each do |a|
          self.send(:attr_accessor, a)
        end

        @@columns
      end
    end

    def database
      App.get_instance.database
    end

    def find_by(hash={})
      self.database.execute(

        "SELECT * FROM #{self.to_s.column_family_name}
        WHERE #{hash[:key]} = #{hash[:value]}"

      )
    end

  end

end