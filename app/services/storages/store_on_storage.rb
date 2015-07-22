class StoreOnStorage
  include Wisper::Publisher

  def execute(user, attributes)

    # Validates Storage
    # validate_storage = storage_are_valid?(user,attributes)
    # broadcast(:store_on_storage_invalid_storage, validate_storage.last) unless validate_storage.first

    # Find Storage based on #attributes information
    storage = Storage.where(email: user.email, name: attributes[:storage], key: attributes[:key]).first
    return(broadcast(:store_on_storage_storage_not_found, attributes)) unless storage

    # Create New Store Class Constructor
    store = Store.new(add_id_attribute(storage.to_h))

    # Construct New Store Classbinding.pry
    begin
      constructor = store.construct.new(set_id_attribute(attributes[:data]))
    rescue
      return broadcast(:store_on_storage_invalid_columns, convert_cassandra_udt_to_hash(storage.structure))
    end

    # Store Data On Storagebinding.pry
    if constructor.create
      broadcast(:store_on_storage_successful, constructor)
    else
      broadcast(:store_on_storage_failed, constructor)
    end

  end

  private

  # Set ID attribute on storage hash(ID Column Will be Implemented Implicit)
  def add_id_attribute(hash)
    hash['structure']['id'] = Cassandra::UDT.new(type: 'Cassandra::TimeUuid', presence: 'true')
    hash
  end

  # Set Timeuuid for Implicit generated column ID
  def set_id_attribute(hash)
    hash[:id] = Cassandra::Uuid::Generator.new.now
    hash
  end

  # Convert Cassandra User Defined Type to ruby hash object
  def convert_cassandra_udt_to_hash(hash)

    hash.map do |k,v|
      { "#{k}" => v.to_h }
    end

  end

end
