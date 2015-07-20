class CreateStorage
  include Wisper::Publisher

  def execute(attributes)

    # Prevent From Mass Assignment
    storage = Storage.new(
      email:                  attributes[:email],
      name:                   attributes[:name],
      key:                    attributes[:key],
      structure:              fix_cassandra_udt(attributes[:structure]),
      column_family_name: (
      (
        (attributes[:email] + '_' + attributes[:name] + '_' + attributes[:key]).gsub(/[@.]/, '_')
      ) if attributes[:email] && attributes[:name] && attributes[:key] )
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