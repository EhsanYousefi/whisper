class GetStorages

  include Wisper::Publisher

  def execute(user)

    begin
      broadcast(:get_storages_successfull, prepare_storages(Storage.where(email: user.email)))
    rescue
      broadcast(:get_storages_failed)
    end

  end

  private

  def prepare_storages(storages)
    storages.map do |storage|
      {
      storage: storage.name,
      key: storage.key,
      structure: convert_cassandra_udt_to_hash(storage.structure)
      }
    end
  end

  def convert_cassandra_udt_to_hash(hash)
    new_hash ={}

    hash.each do |k,v|
      new_hash[k] = v.to_h
    end

    new_hash
  end

end