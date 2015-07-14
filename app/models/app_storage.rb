class AppStorage
  attr_reader :name, :key, :schema

  def initialize(hash={})

    @name = hash.delete :name
    @key  = hash.delete :key
    @schema = hash.delete :schema

    raise ArgumentError if @name.blank? || @key.blank? || @schema.blank?
  end

  def klass

    name = self.name; key = self.key; schema = self.schema

    klass = Class.new(Module) do

      include Cassandra::ColumnFamily

      columns *schema.symbolize_keys!.keys

      class << self

        def do_validation(name, key, schema)

          schema.each do |row|

            if row.last[:presence]
              send(:validates, row.first, { type: row.last[:type].constantize,  presence: true })
            else
              send(:validates, row.first, { type: row.last[:type].constantize })
            end

          end

        end

      end

      do_validation(name, key, schema)

    end

    klass.constantize
  end
end