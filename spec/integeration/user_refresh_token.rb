require 'spec_helper'

describe UserRefreshTokenController do

  before :each do
    clean_database('User')
  end

  let :user do
    user = build :user
    user.create!
    user
  end

  describe 'Refresh User Token' do

    it 'should refresh user token' do

      payload = {}

      post_request '/api/v1/refresh_token', payload.to_json, user

      body = JSON.parse response.body

      expect(response.status).to eql 200
      expect(body['token']).not_to eql nil

    end

    context :failuers do

      context :user_not_authorized do

        it 'should err 401 if unauthorized' do

          payload = {}

          post_request '/api/v1/refresh_token', payload.to_json

          expect(response.status).to eql 401

        end


      end
    end
  end
end
