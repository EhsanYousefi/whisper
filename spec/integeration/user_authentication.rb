require 'spec_helper'

describe UserAuthenticationController do

  before :each do
    clean_database('User')
  end

  let :user do
    user = build :user
    user.create!
    user
  end

  describe 'Authenticate User' do

    it 'should authenticate user' do

      payload = {
        identification: user.user_name,
        password: 'password'
      }

      post_request '/api/v1/login', payload.to_json

      body = JSON.parse response.body

      expect(response.status).to eql 200
      expect(body['token']).not_to eql nil

    end

    context :failuers do

      context :user_name do

        it 'should err if user_name is missing' do

          payload = {
            # identification: user.user_name,
            password: 'password'
          }

          post_request '/api/v1/login', payload.to_json

          expect(response.status).to eql 401

        end

        it 'should err if user_name is not exists in database' do

          payload = {
            identification: 'imnotexists',
            password: 'password'
          }

          post_request '/api/v1/login', payload.to_json

          expect(response.status).to eql 401

        end

      end

      context :password do

        it 'should err if password is missing' do

          payload = {
            identification: user.user_name,
            # password: 'password'
          }

          post_request '/api/v1/login', payload.to_json

          expect(response.status).to eql 401

        end

        it 'should err if password is not valid' do

          payload = {
            identification: user.user_name,
            password: 'invalid'
          }

          post_request '/api/v1/login', payload.to_json

          expect(response.status).to eql 401

        end

      end

    end
  end
end
