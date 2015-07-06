require 'spec_helper'

describe HomeController do
  describe '/' do

    it 'should return page' do
      get '/'
      expect(response.status).to eql 200
    end

  end
end