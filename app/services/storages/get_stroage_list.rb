class GetStorageList

  include Wisper::Publisher

  def execute(user_name)
    # storage_list = StorageList.where(user_name: user_name)
    #
    # storage_list.map do |item|
    #
    #   Storage.where(name: item.name).map  do |storage|
    #     { key: storage.key }
    #   end
    #
    # end
    broadcast(:get_storage_list_successfull, StorageList.where(user_name: user_name))
  end

end
