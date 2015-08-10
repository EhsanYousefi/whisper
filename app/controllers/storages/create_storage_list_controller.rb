class CreateStorageListController < ApplicationController

  before_start :authorized?

  def main

    storage_list = CreateStorageList.new

    storage_list.on(:create_storage_list_successful) do |sl|

      app.status 201
      return app.json storage_list: { id: sl.key, key: sl.key, description: sl.description }

    end

    storage_list.on(:create_storage_list_failed) do |sl|

      app.status 422
      return app.json errors: sl.errors.messages

    end

    storage_list.execute(current_user.user_name, app.params)

  end

end
