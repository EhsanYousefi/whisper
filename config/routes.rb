class App

  get '/' do
    controller HomeController
  end

  post '/registration' do
    controller CreateUserController
  end

  post '/authentication' do
    controller UserAuthenticationController
  end

end