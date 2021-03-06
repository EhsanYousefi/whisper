require 'spec_helper'

describe CreateUserController do

  after(:each) do
    clean_database('User')
  end

  describe 'Create User' do

    it 'should register an user' do

      payload = {
        user: {
          user_name: 'ehsan_yousefi',
          email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'jackjack',
          first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
        }
      }

      post_request '/api/v1/users', payload.to_json

      body = JSON.parse response.body
      binding.pry
      expect(response.status).to eql 201


      expect(body['email']).to eql payload[:email]
      expect(body['first_name']).to eql payload[:first_name]
      expect(body['last_name']).to eql payload[:last_name]
      expect(body['company']).to eql payload[:company]
      expect(body['token']).to_not eql nil

    end

    context :failures do

      context :user_name do

        it 'should err if user_name is missing' do

          payload = {
          # user_name: 'ehsan_yousefi',
          email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'jackjack',
          first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err if user_name is not valid' do

          payload = {
          user_name: '&invalid', # Invalid UserName
          email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'jackjack',
          first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err if user_name is not string' do

          payload = {
          user_name: 2222222,
          email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'jackjack',
          first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

      end

      context :email do

        it 'should err if email missing' do

          payload = {
          user_name: 'ehsan_yousefi',
          # email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'jackjack',
          first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err if email is not string' do

          payload = {
          user_name: 'ehsan_yousefi',
          email: 23232323232323,
          password: 'jackjack',
          password_confirmation: 'jackjack',
          first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err if email is not valid' do

          payload = {
          user_name: 'ehsan_yousefi',
          email: 'infogoogle.com', # Invalid Email
          password: 'jackjack',
          password_confirmation: 'jackjack',
          first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

      end

      context :password do

        it 'should err if password is missing' do

          payload = {
          user_name: 'ehsan_yousefi',
          email: 'e.yousefi@roundtableapps.com',
          # password: 'jackjack',
          password_confirmation: 'jackjack',
          first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err password does not match with password confirmation' do

          payload = {
          user_name: 'ehsan_yousefi',
          email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'password_does_not_match',
          first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

      end

      context :first_name do

        it 'should err if first_name is missing' do

          payload = {
          user_name: 'ehsan_yousefi',
          email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'password_does_not_match',
          # first_name: 'Ehsan',
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err if first_name is not string' do

          payload = {
          user_name: 'ehsan_yousefi',
          email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'password_does_not_match',
          first_name: 24234324234, # As You see first name is not string
          last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

      end

      context :last_name do

        it 'should err if last_name is missing' do

          payload = {
          user_name: 'ehsan_yousefi',
          email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'password_does_not_match',
          first_name: 'Ehsan',
          # last_name: 'Yousefi',
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err if last_name is not string' do

          payload = {
          user_name: 'ehsan_yousefi',
          email: 'e.yousefi@roundtableapps.com',
          password: 'jackjack',
          password_confirmation: 'password_does_not_match',
          first_name: 'Ehsan',
          last_name: 3432424234, # As you can see is not string
          company: 'RoundTableApps'
          }

          post_request '/api/v1/users', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

      end

    end
  end
end
