class GetStoragesController < ApplicationController

  before_start :authorized?

  def main
    storages = GetStorages.new

    storages.on(:get_storages_successfull) do |storages|

      app.status 200
      rsp =  storages.map do |storage|

        {
          id: storage.key,
          name: storage.name,
          key: storage.key,
          pattern: storage.pattern,
          sort: storage.sort,
          structure: JSON.prase(storage.structure)
        }

      end

      return app.json storage: rsp

    end

    storages.on(:get_storages_failed) do

      app.status 200
      return app.json sotrage: []

    end

    storages.execute(current_user, app.params)

  end


end
