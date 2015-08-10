class Storage

  include Cassandra::ColumnFamily

  columns(
    user_name:          { type: String },
    name:               { type: String },
    key:                { type: String },
    sort:               { type: String },
    pattern:            { type: String },
    column_family_name: { type: String },
    structure:          { type: String }
  )

  validates :user_name,           presence: true, format: { without: /\W/, message: 'is incorrect' }, uniq_with: [:name, :key]
  validates :name,                presence: true, format: { without: /\W/, message: 'is incorrect' }
  validates :key,                 presence: true, format: { without: /\W/, message: 'is incorrect' }
  validates :sort,                presence: true, inclusion: { in: %w(asc desc), message: "%{value} is not valid sort type" }
  validates :pattern,             presence: true, inclusion: { in: %w(time_series counter), message: "%{value} is not valid pattern" }
  validates :column_family_name,  presence: true

  validate  :validate_structure

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

    begin

      validator = "StorageStructure::#{self.pattern.classify.constantize}".new(struct)

      unless validator.valid?
        validator.errors.each do |err|
          errors.add(:structure, err)
        end
      end


    rescue
      false
    end


  end

end
