class GetStorages

  include Wisper::Publisher

  def execute(user, attributes)

    begin
      broadcast(:get_storages_successfull, Storage.where(user_name: user.user_name, storage: attributes[:storage] ))
    rescue
      broadcast(:get_storages_failed)
    end

  end

end
