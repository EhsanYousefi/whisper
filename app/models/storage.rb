class Storage

  include Cassandra::ColumnFamily

  columns(
  user_name:          String,
  name:               String,
  key:                String,
  sort:               String,
  column_family_name: String,
  structure:          String
  )

  validates :user_name,   presence: true, format: { without: /\W/, message: 'is incorrect' }, uniq_with: [:name, :key]
  validates :name,        presence: true, format: { without: /\W/, message: 'is incorrect' }
  validates :key,         presence: true, format: { without: /\W/, message: 'is incorrect' }
  validates :sort,        presence: true, inclusion: { in: %w(asc desc), message: "%{value} is not valid sort type" }
  validates :column_family_name, presence: true

  validate  :validate_structure

  VALID_TYPES = ['String', 'Integer', 'Float', 'Time']

  # ReImplement Structure Getter method
  def structure
    if @structure.kind_of?(Hash)
      @structure = @structure.to_json
    else
      @structure
    end
  end

  private

  def validate_structure

    begin
      struct = JSON.parse self.structure
    rescue
      return errors.add(:structure, "should be json object")
    end

    validator = StorageStructureValidator.new(struct)

    unless validator.valid?
      validator.errors.each do |err|
        errors.add(:structure, err)
      end
    end

  end

end
