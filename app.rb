class App < Sinatra::Base

  include Core::Info
  include Core::Reloader
  include Core::Helpers::Router
  include Core::Database

  options '/*' do
    response["Access-Control-Allow-Headers"] = "origin, x-requested-with, content-type, token"
    response["Access-Control-Allow-Origin"] = '*'
  end

  def params
    begin
      @param ||= JSON.parse(request.body.gets).with_indifferent_access
    rescue
      super
    end
  end

end
