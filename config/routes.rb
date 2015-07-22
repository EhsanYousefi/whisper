class App

  get '/' do
    controller HomeController
  end

  post '/api/v1/register' do
    controller CreateUserController
  end

  post '/api/v1/login' do
    controller UserAuthenticationController
  end

  post '/api/v1/storage/create' do
    controller CreateStorageController
  end

  post '/api/v1/storage/store' do
    controller StoreController
  end

  # get '/api/v1/storage/:storage/:key/page/:number' do
  #   controller GetDataFromStorageController
  # end

  get '/api/v1/storages' do
    controller GetStoragesController
  end

end
