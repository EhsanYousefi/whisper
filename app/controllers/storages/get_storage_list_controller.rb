class GetStorageListController < ApplicationController

  before_start :authorized?

  def main

    storage_list = GetStorageList.new

    storage_list.on(:get_storage_list_successfull) do |storages|

      app.status 200

      resp = storages.map do |storage|

        {
          id: storage.key,
          key: storage.key,
          description: storage.description
        }

      end

      return app.json storage_list: resp

    end

    storage_list.execute(current_user.user_name)

  end

end
