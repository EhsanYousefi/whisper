require 'spec_helper'

describe StoreController do

  before(:each) do
    clean_database('User', 'Storage')
  end

  after(:each) do
    clean_database('User', 'Storage')
  end

  let :user do
    user = build :user
    user.create!
    user
  end

  let :user_storage do
    storage = build(
      :storage,
      email: user.email,
      name: 'whisper',
      key: 'logs'
    )

    binding.pry
    storage.create!
    storage
  end

  describe 'Store Data On Storage' do

    it 'should store data on sepecfied storage' do
      # Create Storage
      user_storage

      payload = {
        storage: 'whisper',
        key: 'logs',
        data: {
          field: 'This is string field',
          field_1: 1 # This is integer field
        }
      }

      post_request '/api/v1/storage/store', payload, user

      body = JSON.parse response.body
      expect(response.body).to eql 201

    end

  end


end