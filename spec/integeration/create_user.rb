require 'spec_helper'

describe CreateUserController do

  after(:each) do
    clean_database('User')
  end

  describe 'Create User' do

    it 'should register an user' do

      payload = {
        email: 'e.yousefi@roundtableapps.com',
        password: 'jackjack',
        password_confirmation: 'jackjack',
        first_name: 'Ehsan',
        last_name: 'Yousefi',
        company: 'RoundTableApps'
      }

      post_request '/api/v1/register', payload.to_json

      body = JSON.parse response.body

      expect(response.status).to eql 201

      expect(body['email']).to eql payload[:email]
      expect(body['first_name']).to eql payload[:first_name]
      expect(body['last_name']).to eql payload[:last_name]
      expect(body['company']).to eql payload[:company]
      expect(body['token']).to_not eql nil

    end

    context :failures do

      context :email do

        it 'should err if email missing' do

          payload = {
            # email: 'e.yousefi@roundtableapps.com',
            password: 'jackjack',
            password_confirmation: 'jackjack',
            first_name: 'Ehsan',
            last_name: 'Yousefi',
            company: 'RoundTableApps'
          }

          post_request '/api/v1/register', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).to_not eql nil

        end

        it 'should err if email is not string' do

          payload = {
            email: 23232323232323,
            password: 'jackjack',
            password_confirmation: 'jackjack',
            first_name: 'Ehsan',
            last_name: 'Yousefi',
            company: 'RoundTableApps'
          }

          post_request '/api/v1/register', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).to_not eql nil

        end

        it 'should err if email is not valid' do

          payload = {
            email: 'infogoogle.com', # Invalid Email
            password: 'jackjack',
            password_confirmation: 'jackjack',
            first_name: 'Ehsan',
            last_name: 'Yousefi',
            company: 'RoundTableApps'
          }

          post_request '/api/v1/register', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).to_not eql nil

        end

      end

      context :password do

        it 'should err if password is missing' do

          payload = {
            email: 'e.yousefi@roundtableapps.com',
            # password: 'jackjack',
            password_confirmation: 'jackjack',
            first_name: 'Ehsan',
            last_name: 'Yousefi',
            company: 'RoundTableApps'
          }

          post_request '/api/v1/register', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).to_not eql nil

        end

        it 'should err password does not match with password confirmation' do

          payload = {
            email: 'e.yousefi@roundtableapps.com',
            password: 'jackjack',
            password_confirmation: 'password_does_not_match',
            first_name: 'Ehsan',
            last_name: 'Yousefi',
            company: 'RoundTableApps'
          }

          post_request '/api/v1/register', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).to_not eql nil

        end

      end

      context :first_name do

        it 'should err if first_name is missing' do

          payload = {
            email: 'e.yousefi@roundtableapps.com',
            password: 'jackjack',
            password_confirmation: 'password_does_not_match',
            # first_name: 'Ehsan',
            last_name: 'Yousefi',
            company: 'RoundTableApps'
          }

          post_request '/api/v1/register', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).to_not eql nil

        end

        it 'should err if first_name is not string' do

          payload = {
            email: 'e.yousefi@roundtableapps.com',
            password: 'jackjack',
            password_confirmation: 'password_does_not_match',
            first_name: 24234324234, # As You see first name is not string
            last_name: 'Yousefi',
            company: 'RoundTableApps'
          }

          post_request '/api/v1/register', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).to_not eql nil

        end

      end

      context :last_name do

        it 'should err if last_name is missing' do

          payload = {
            email: 'e.yousefi@roundtableapps.com',
            password: 'jackjack',
            password_confirmation: 'password_does_not_match',
            first_name: 'Ehsan',
            # last_name: 'Yousefi',
            company: 'RoundTableApps'
          }

          post_request '/api/v1/register', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).to_not eql nil

        end

        it 'should err if last_name is not string' do

          payload = {
            email: 'e.yousefi@roundtableapps.com',
            password: 'jackjack',
            password_confirmation: 'password_does_not_match',
            first_name: 'Ehsan',
            last_name: 3432424234, # As you can see is not string
            company: 'RoundTableApps'
          }

          post_request '/api/v1/register', payload.to_json

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).to_not eql nil

        end

      end

    end
  end
end