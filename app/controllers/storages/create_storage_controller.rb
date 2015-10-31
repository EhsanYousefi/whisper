class CreateStorageController < ApplicationController

  before_start :authorized?

  def main
    create_storage = CreateStorage.new

    # create_storage.subscribe(CreateColumnFamily)

    create_storage.on(:create_storage_successful) do |storage|

      app.status 201

      return app.json(
        name: storage.name,
        key: storage.key,
        sort: storage.sort,
        structure: JSON.parse(storage.structure)
      )

    end

    create_storage.on(:create_storage_failed) do |storage|

      app.status 422
      return app.json({ errors: storage.errors.messages.merge({ array_errors: storage.errors.full_messages }) })
      # return app.json({ errors: storage.errors.messages , array_erros: storage.errors.full_messages })

    end

    create_storage.execute(create_storage_params)

  end

  private

  def create_storage_params
    app.params[:user_name] = current_user.user_name
    app.params
  end

end
