class App

  # get '*' do
  #   send_file "#{App.root}/dist/index.html"
  # end

  get '/' do
    controller HomeController
  end

  post '/api/v1/users' do
    controller CreateUserController
  end

  post '/api/v1/login' do
    controller UserAuthenticationController
  end

  post '/api/v1/refresh_token' do
    controller UserRefreshTokenController
  end

  post '/api/v1/storages' do
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

  get '/api/v1/storage_lists' do
    controller GetStorageListController
  end

  patch '/api/v1/user' do
    controller UpdateUserController
  end

  post '/api/v1/storage_lists' do
    controller CreateStorageListController
  end

end
