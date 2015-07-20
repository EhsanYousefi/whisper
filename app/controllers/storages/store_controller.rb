class StoreController < ApplicationController

  before_start :authorized?

  def main
    store = StoreOnStorage.new

    store.on(:store_on_storage_invalid_attributes) do |storage|

      app.status 400
      return app.json validation_error: storage.errors.to_h

    end

    store.on(:store_on_storage_successful) do |store|

      app.status 201
      return app.json store.as_json

    end

    store.on(:store_on_storage_failed) do |store|

      app.status 400
      return app.json validation_error: store.errors.to_h

    end

    store.execute(current_user, app.params)

  end

end