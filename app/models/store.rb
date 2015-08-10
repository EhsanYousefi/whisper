class Store
  attr_reader :name, :key, :structure, :column_family_name

  def initialize(hash={})

    @name = hash.delete :name
    @key  = hash.delete :key
    @column_family_name = hash.delete :column_family_name
    @structure = hash.delete(:structure)

    # We should do all of validation on storage class TODO
    raise ArgumentError if @name.blank? || @key.blank? || @structure.blank?
  end

  def prepare_columns

    hash = {}

    @structure.each do |k,v|
        # TODO you should remove classify constantize
        hash[k] = {type: v['type'].classify.constantize , default: v['default']}

    end

    hash

  end

  def construct

    name = self.name; key = self.key; structure = self.structure; cfn = self.column_family_name; cols = self.prepare_columns

    klass = Class.new(Module) do

      include Cassandra::ColumnFamily

      columns(cols)

      class << self

        def do_validation(name, key, structure)

          structure.each do |row|

            send(:validates, row.first, { presence: true })  if row.last['required'] == true

          end

        end

      end

      do_validation(name, key, structure)

    end
    # Set Class Column Family name
    klass._column_family_name = cfn

    begin
      self.class::Construct
    rescue
      self.class.const_set('Construct', klass)
    end

  end
end
