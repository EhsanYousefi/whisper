require 'spec_helper'

describe GetStorageListController do

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
    sl = build(:storage_list, user_name: user.user_name)
    sl.create!
    sl
  end

  let :storage_list_2 do
    sl = build(:storage_list, user_name: user.user_name)
    sl.create!
    sl
  end

  describe 'Get User Storages List' do

    it 'should get user storages list' do
      storage_list
      storage_list_2

      payload = {}

      get_request '/api/v1/users/storage_list', payload , user


      body = JSON.parse response.body

      expect(response.status).to eql 200
      expect(body['storage_lists']).not_to eql nil

    end

  end

end
