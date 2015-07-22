class GetStoragesController < ApplicationController

  before_start :authorized?

  def main

    storages = GetStorages.new

    storages.on(:get_storages_successfull) do |storages|

      app.status 200
      return app.json storages

    end

    storages.on(:get_storages_failed) do

      app.status 503
      return app.json error: "Server is currently unavailable"

    end

    storages.execute(@current_user)

  end


end