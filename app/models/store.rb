class Store
  attr_reader :name, :key, :structure, :column_family_name

  def initialize(hash={})

    @name = hash.delete :name
    @key  = hash.delete :key
    @column_family_name = hash.delete :column_family_name
    @structure = hash.delete :structure

    raise ArgumentError if @name.blank? || @key.blank? || @structure.blank?
  end

  def construct

    name = self.name; key = self.key; structure = self.structure; cfn = self.column_family_name

    klass = Class.new(Module) do

      include Cassandra::ColumnFamily

      columns *structure.keys

      class << self

        def do_validation(name, key, structure)

          structure.each do |row|

            row_last = row.last.to_h.with_indifferent_access

            if row_last[:presence]
              send(:validates, row.first, { type: row_last[:type].classify.constantize,  presence: true })
            else
              send(:validates, row.first, { type: row_last[:type].classify.constantize })
            end

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
