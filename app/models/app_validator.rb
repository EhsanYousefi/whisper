class AppValidator

  include ActiveModel::Model

  attr_accessor :name, :key, :storage

  validates :name,        presence: true, type: String
  validates :key,         presence: true, type: String
  validate :schema # Validate Schema Hash

  VALID_TYPES = ['String', 'Integer', 'Float', 'Time', 'Hash', 'Array']

  def validate_schema

    unless schema.kind_of?(Hash)
      return errors.add(:schema, "should be json object")
    end

    schema = schema.with_indifferent_access

    validates_blank = schema.map do |s|
      !s[:type].blank? || !s[:presence].blank?
    end

    return errors.add(:schema, "invalid format") if validates_blank.include? false

    validates_type = schema.map do |s|
      !VALID_TYPES.include? s[:type].capitalize
    end

    return errors.add(:schema, "invalid type") if validates_type.include? false

    validates_presence = schema.map do |s|
      s[:presence] == true ||  s[:presence] == false || s[:presence] == 'true' || s[:presence] == 'false'
    end

    return errors.add(:schema, "schema -> presence should be true or false") if validates_presence.include? false

  end



end