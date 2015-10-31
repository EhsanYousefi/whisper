require 'spec_helper'

describe GetStoragesController do

  before(:each) do
    # Drop Table which created in runtime
    begin

      App.database.execute("
        DROP TABLE #{whisper_column_family_name}
      ")

      App.database.execute("
        DROP TABLE #{crowdship_column_family_name}
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
        DROP TABLE #{whisper_column_family_name}
      ")

      App.database.execute("
        DROP TABLE #{crowdship_column_family_name}
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

  let :create_crowdship_storage do

    # Create User Storage Based On HTTP Api(Not Explicit)
    payload = {
    name: 'crowdship',
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

  let :create_whisper_storage do

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

  let :whisper_column_family_name do
    "#{email}_whisper_logs".gsub /[@.]/, '_'
  end

  let :crowdship_column_family_name do
    "#{email}_crowdship_logs".gsub /[@.]/, '_'
  end


  describe 'Return All User defined storages' do

    it 'should return user defined storages' do

      # Create Some Storages before continue
      create_crowdship_storage
      create_whisper_storage

      get_request '/api/v1/storages', {}, user

      body = JSON.parse response.body

      expected_body = [{"storage"=>"crowdship",
      "key"=>"logs",
      "structure"=>
      {"message"=>{"type"=>"string", "presence"=>"true", "searchable"=>"false"},
      "severity"=>{"type"=>"integer", "presence"=>"true", "searchable"=>"true"},
      "time"=>{"type"=>"time", "presence"=>"true", "searchable"=>"true"}}},
      {"storage"=>"whisper",
      "key"=>"logs",
      "structure"=>
      {"message"=>{"type"=>"string", "presence"=>"true", "searchable"=>"false"},
      "severity"=>{"type"=>"integer", "presence"=>"true", "searchable"=>"true"},
      "time"=>{"type"=>"time", "presence"=>"true", "searchable"=>"true"}}}]

      expect(body.size).to eql 2
      expect(response.status).to eql 200

    end

    context :failuers do

      it 'should err if something went wrong' do

        # Create Some Storages before continue
        create_crowdship_storage
        create_whisper_storage

        Storage.stub(:where).and_raise(ArgumentError)

        get_request '/api/v1/storages', {}, user

        expect(response.status).to eql 503
      end

    end
  end

end