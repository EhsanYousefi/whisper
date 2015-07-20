class App < Sinatra::Base

  include Core::Info
  include Core::Reloader
  include Core::Helpers::Router
  include Core::Database

  def params
    begin
      @param ||= JSON.parse(request.body.gets).with_indifferent_access
    rescue
      {}
    end
  end

end
