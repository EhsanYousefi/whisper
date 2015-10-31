class GetDataFromStorageController < ApplicationController

  before_start :authorized?

  def main

    data = GetDataFromStorage.new

    data.on(:get_data_from_storage_successful) do |data|

      app.status 200
      return app.json data.as_json

    end

    data.on(:get_data_from_storage_failed) do |data|

      app.status 400
      return app.json error: "Invalid Storage || Key"
    end

    data.execute(user, app.params)

  end

end