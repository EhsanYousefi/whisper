require 'spec_helper'

describe CreateStorageListController do

  before(:each) do
    clean_database('User', 'StorageList')
  end

  after(:each) do
    clean_database('User', 'StorageList')
  end

  let :user do
    user = build :user
    user.create!
    user
  end

  let :storage_list do
    sl = build(:storage_list, user_name: user.user_name, key: 'voyager')
    sl.create!
    sl
  end

  describe 'Create Storage List' do

    it 'should create storage list' do

      payload = {
        key: 'voyager',
        description: 'test desc'
      }

      post_request '/api/v1/storage_lists', payload.to_json, user

      body = JSON.parse response.body
      expect(response.status).to eql 201
      expect(body['storage_list']).to_not eql nil

    end

    context :failuers do

      context :key do

        it 'should err if blank' do

          payload = {
            key: '',
            description: 'test desc'
          }

          post_request '/api/v1/storage_lists', payload.to_json, user

          body = JSON.parse response.body
          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err if nil' do

          payload = {
            key: nil,
            description: 'test desc'
          }

          post_request '/api/v1/storage_lists', payload.to_json, user

          body = JSON.parse response.body
          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err if missing' do

          payload = {
            # key: nil
            description: 'test desc'
          }

          post_request '/api/v1/storage_lists', payload.to_json, user

          body = JSON.parse response.body
          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

        it 'should err if exists' do
          # Create StorageList
          storage_list

          payload = {
            key: 'voyager',
            description: 'test desc'
          }

          post_request '/api/v1/storage_lists', payload.to_json, user

          body = JSON.parse response.body
          expect(response.status).to eql 422
          expect(body['errors']).to_not eql nil

        end

      end
    end

  end

end
