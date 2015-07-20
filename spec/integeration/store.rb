require 'spec_helper'

describe StoreController do

  before(:each) do
    # Drop Table which created in runtime
    begin
      App.database.execute("
        DROP TABLE #{column_family_name}
      ")
    rescue
      true
    end

    clean_database('User', 'Storage')
  end

  after(:each) do
    # Drop Table which created in runtime
    begin
      App.database.execute("
        DROP TABLE #{column_family_name}
      ")
    rescue
      true
    end

    clean_database('User', 'Storage')
  end

  let :email do
    "roundtableapps@gmail.com"
  end

  let :user do
    user = build(:user, email: email)
    user.create!
    user
  end

  let :user_storage do

    # Create User Storage Based On HTTP Api(Not Explicit)
    payload = {
      name: 'whisper',
      key: 'logs',
      structure: {
        severity: {
          type: 'integer',
          presence: 'true',
          searchable: 'true'
        },
        time: {
          type: 'time',
          presence: 'true',
          searchable: 'true'
        },
        message: {
          type: 'string',
          presence: 'true',
          searchable: 'false'
        },
      },
    }.to_json

    post_request '/api/v1/storage/create', payload, user

  end

  let :column_family_name do
    "#{email}_whisper_logs".gsub /[@.]/, '_'
  end

  describe 'Store Data On Storage' do

    it 'should store data on sepecfied storage' do
      # Create Storage
      user_storage

      payload = {
        storage: 'whisper',
        key: 'logs',
        data: {
          severity: 2,
          time: Time.now.to_i,
          message: "Hello world this is my first log message"
        },
      }.to_json

      post_request '/api/v1/storage/store', payload, user

      body = JSON.parse response.body
      expect(response.body).to eql 201

    end

  end


end
