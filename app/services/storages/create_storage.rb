class CreateStorage
  include Wisper::Publisher

  def execute(attributes)

    # Prevent From Mass Assignment
    storage = Storage.new(
      user_name:              attributes[:user_name],
      name:                   attributes[:name],
      key:                    attributes[:key],
      structure:              fix_cassandra_udt(attributes[:structure]),
      column_family_name: (
      (
        (attributes[:user_name] + '_' + attributes[:name] + '_' + attributes[:key])
      ) if attributes[:user_name] && attributes[:name] && attributes[:key] )
    )

    if storage.create
      broadcast(:create_storage_successful, storage)
    else
      broadcast(:create_storage_failed, storage)
    end

  end

  private

  def fix_cassandra_udt(hash)
    return unless hash
    
    new_hash = {}

    hash.each do |k,v|
      new_hash[k] = Cassandra::UDT.new(v)
    end

    new_hash
  end

end