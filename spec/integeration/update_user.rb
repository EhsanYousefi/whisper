require 'spec_helper'

describe UpdateUserController do

  before :each do
    clean_database('User')
  end

  let :user do
    user = build :user
    user.create!
    user
  end

  describe 'Update User Info' do

    it 'should update user info' do

      payload = {
      email: 'ehsan.yousefi@live.com',
      first_name: 'Ehsan',
      last_name: 'Yousefi',
      company: 'RTA'
      }

      patch_request '/api/v1/user', payload.to_json , user

      body = JSON.parse response.body

      expected_body = {
      "user_name"=>"#{user.user_name}",
      "email"=>"ehsan.yousefi@live.com",
      "first_name"=>"Ehsan",
      "last_name"=>"Yousefi",
      "company"=>"RTA"
      }

      expect(response.status).to eql 202
      expect(body).to eql expected_body

    end

    it 'should not update user_name' do

      payload = {
      user_name: 'new_user_name',
      email: 'ehsan.yousefi@live.com',
      first_name: 'Ehsan',
      last_name: 'Yousefi',
      company: 'RTA'
      }

      patch_request '/api/v1/user', payload.to_json , user

      body = JSON.parse response.body

      expected_body = {
      "user_name"=>"#{user.user_name}", # User name should not be changed
      "email"=>"ehsan.yousefi@live.com",
      "first_name"=>"Ehsan",
      "last_name"=>"Yousefi",
      "company"=>"RTA"
      }

      expect(response.status).to eql 202
      expect(body).to eql expected_body

    end

    it 'should not update user_name if payload only contains user_name' do

      payload = {
      user_name: 'new_user_name',
      }

      patch_request '/api/v1/user', payload.to_json , user

      body = JSON.parse response.body

      expect(response.status).to eql 400
      expect(body['error']).to_not eql nil

    end

    it 'should update email' do

      payload = {
      email: 'ehsan.yousefi@live.com'
      }

      patch_request '/api/v1/user', payload.to_json , user

      body = JSON.parse response.body

      expected_body = {
      "user_name"=>"#{user.user_name}",
      "email"=>"ehsan.yousefi@live.com",
      "first_name"=>"#{user.first_name}",
      "last_name"=>"#{user.last_name}",
      "company"=>"#{user.company}"
      }

      expect(response.status).to eql 202
      expect(body).to eql expected_body

    end

    it 'should update first_name' do

      payload = {
      first_name: 'Ehsan'
      }

      patch_request '/api/v1/user', payload.to_json , user

      body = JSON.parse response.body

      expected_body = {
      "user_name"=>"#{user.user_name}",
      "email"=>"#{user.email}",
      "first_name"=>"Ehsan",
      "last_name"=>"#{user.last_name}",
      "company"=>"#{user.company}"
      }

      expect(response.status).to eql 202
      expect(body).to eql expected_body

    end

    context :failuers do

      context :email do

        it 'should err if email invalid' do

          payload = {
          email: 'ehsan.yousefilive.com' #invalid email
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

        it 'should err if email is blank' do

          payload = {
          email: '' #invalid email
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

        it 'should err if email is nil' do

          payload = {
          email: nil #invalid email
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

        it 'should err if email is integer' do

          payload = {
          email: 1212344 #invalid email
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

      end

      context :first_name do

        it 'should err if blank' do

          payload = {
          first_name: '' #invalid first_name
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

        it 'should err if nil' do
          payload = {
          first_name: nil #invalid first_name
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

        it 'should err if not string' do

          payload = {
          first_name: 343434 #invalid first_name
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

      end

      context :last_name do

        it 'should err if blank' do

          payload = {
          last_name: '' #invalid last_name
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

        it 'should err if nil' do
          payload = {
          last_name: nil #invalid last_name
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

        it 'should err if not string' do

          payload = {
          last_name: 343434 #invalid last_name
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

      end

      context :company do

        it 'should err if not string' do

          payload = {
          company: 343434 #invalid company
          }

          patch_request '/api/v1/user', payload.to_json , user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body['validation_error']).not_to eql nil

        end

      end

    end
  end
end