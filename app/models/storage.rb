class Storage

  include Cassandra::ColumnFamily

  columns :user_name, :name, :key, :column_family_name, :structure

  validates :user_name,   presence: true, type: String, format: { without: /\W/, message: 'is incorrect' }, uniq_with: [:name, :key]
  validates :name,        presence: true, type: String, format: { without: /\W/, message: 'is incorrect' }
  validates :key,         presence: true, type: String, format: { without: /\W/, message: 'is incorrect' }
  validates :column_family_name, presence: true, type: String
  validates :structure,   presence: true

  validate  :validate_structure

  VALID_TYPES = ['String', 'Integer', 'Float', 'Time']

  private

  def validate_structure
    unless self.structure.kind_of?(Hash)
      return errors.add(:structure, "should be json object")
    end

    structure = self.structure.with_indifferent_access

    validates_blank = structure.map do |s|
      h = s.last.to_h
      !h['type'].blank? || !h['presence'].blank?
    end

    return errors.add(:structure, "invalid format") if validates_blank.include? false

    validates_type = structure.map do |s|
      h = s.last.to_h
      !h['type'].nil? && VALID_TYPES.include?(h['type'].capitalize)
    end

    return errors.add(:structure, "invalid type") if validates_type.include? false

    validates_presence = structure.map do |s|
      h = s.last.to_h
      h['presence'] == 'true' ||  h['presence'] == 'false'
    end

    return errors.add(:structure, "structure -> presence should be true or false") if validates_presence.include? false

    validates_searchable = structure.map do |s|
      h = s.last.to_h
      h['searchable'] == 'true' ||  h['searchable'] == 'false'
    end

    return errors.add(:structure, "structure -> searchable should be true or false") if validates_searchable.include? false

    validates_presence_and_searchable = structure.map do |ps|
      h = ps.last.to_h
      !(h['presence'] == 'false' && h['searchable'] == 'true')
    end

    return errors.add(:structure, "structure -> serachable data is mandatory! please set presence -> true") if validates_presence_and_searchable.include? false

  end

end