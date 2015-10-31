class CreateStorageList

  include Wisper::Publisher

  def execute(user_name, attributes)

    sl = StorageList.new(
      user_name: user_name,
      key: attributes[:storage_list][:key],
      description: attributes[:storage_list][:description]
    )

    if sl.create
      broadcast(:create_storage_list_successful, sl)
    else
      broadcast(:create_storage_list_failed, sl)
    end

  end

end
