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

end