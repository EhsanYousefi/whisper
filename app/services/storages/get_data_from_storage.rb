class GetDataFromStorage
  include Wisper::Publisher

  def execute(user, attributes)

    storage = Storage.where(user_name: user.user_name, name: attributes[:storage], key: attributes[:key]).first
    return(broadcast(:get_data_from_storage_storage_not_found, attributes)) unless storage

    # Create New Store Class Constructor
    store = Store.new(add_id_attribute(storage.to_h))

    # Construct New Store Classbinding.pry
    begin
      constructor = store.construct.where()
    end

  end

  private
  # Set ID attribute on storage hash(ID Column Will be Implemented Implicit)
  def add_id_attribute(hash)
    hash['structure']['id'] = Cassandra::UDT.new(type: 'Cassandra::TimeUuid', presence: 'true')
    hash
  end

end