class App < Sinatra::Base

  include Core::Info
  include Core::Reloader
  include Core::Helpers::Router
  include Core::Database

end