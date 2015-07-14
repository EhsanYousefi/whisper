require 'spec_helper'

describe CreateAppController do

  after(:each) do
    clean_database('User')
  end

  describe 'Create App' do

    it 'should create app' do

      payload = {
        name: 'voyager',
        key: 'logs',
        schema: {
          severity: {
            type: 'Integer',
            presence: true
          },
          time: {
            type: 'Integer',
            presence: true
          },
          message: {
            type: 'String',
            presence: true
          }
        }
      }

      post '/api/v1/app/create', payload

      body = JSON.parse response.body

      expect(response.status).to eql 201
    end

  end

end