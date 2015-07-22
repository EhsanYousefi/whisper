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
          presence: 'false',
          searchable: 'false'
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

      expect(body['id']).to_not eql nil
      expect(response.status).to eql 201

    end

    context :failuers do

      context :storage do

        it 'should error 404 if storage is invalid' do

          user_storage

          payload = {
            storage: 'invalid_storage',
            key: 'logs',
            data: {
              severity: 2,
              time: Time.now.to_i,
              message: "Hello world this is my first log message"
            },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 404

        end

        it 'should error 404 if storage is blank' do

          user_storage

          payload = {
            storage: '',
            key: 'logs',
            data: {
              severity: 2,
              time: Time.now.to_i,
              message: "Hello world this is my first log message"
            },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 404

        end

        it 'should error 404 if storage is not present' do

          user_storage

          payload = {
            # storage: 'invalid_storage',
            key: 'logs',
            data: {
              severity: 2,
              time: Time.now.to_i,
              message: "Hello world this is my first log message"
            },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 404

        end
      end

      context :key do

        it 'should err 404 if key is invalid' do

          user_storage

          payload = {
            storage: 'whisper',
            key: 'invalid_key',
            data: {
              severity: 2,
              time: Time.now.to_i,
              message: "Hello world this is my first log message"
            },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 404

        end

        it 'should err 404 if key is blank' do

          user_storage

          payload = {
            storage: 'whisper',
            key: '',
            data: {
              severity: 2,
              time: Time.now.to_i,
              message: "Hello world this is my first log message"
            },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 404

        end

        it 'should err 404 if key is not present' do

          user_storage

          payload = {
            storage: 'whisper',
            # key: 'invalid_key',
            data: {
              severity: 2,
              time: Time.now.to_i,
              message: "Hello world this is my first log message"
            },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 404

        end
      end

      context :storage_and_key do

        it 'should err 404 if storage and key are blank' do

          user_storage

          payload = {
            storage: '',
            key: '',
            data: {
              severity: 2,
              time: Time.now.to_i,
              message: "Hello world this is my first log message"
            },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 404

        end

        it 'should err 404 if storage and key are not present' do

          user_storage

          payload = {
            # storage: '',
            # key: '',
            data: {
              severity: 2,
              time: Time.now.to_i,
              message: "Hello world this is my first log message"
            },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 404

        end
      end

      context :data do

        it 'should err 400 if data is missing' do

          user_storage

          payload = {
            storage: 'whisper',
            key: 'logs',
            # data: {
            #   severity: 2,
            #   time: Time.now.to_i,
            #   message: "Hello world this is my first log message"
            # },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 400

        end

        it 'should err 400 if data format is wrong' do

          user_storage

          payload = {
            storage: 'whisper',
            key: 'logs',
            data: {
              severity: 2,
              time: Time.now.to_i,
              message: "Hello world this is my first log message",
              undifined: 'undifiend'
            },
          }.to_json

          post_request '/api/v1/storage/store', payload, user

          body = JSON.parse response.body

          expect(body['error']).to_not eql nil
          expect(response.status).to eql 400

        end

        context :severity do

          it 'should err if severity is missing' do

            user_storage

            payload = {
              storage: 'whisper',
              key: 'logs',
              data: {
                # severity: 2,
                time: Time.now.to_i,
                message: "Hello world this is my first log message"
              },
            }.to_json

            post_request '/api/v1/storage/store', payload, user

            body = JSON.parse response.body

            expect(body['validation_error']).to_not eql nil
            expect(response.status).to eql 400

          end

          it 'should err if severity is not integer' do

            user_storage

            payload = {
              storage: 'whisper',
              key: 'logs',
              data: {
                severity: '2', # String
                time: Time.now.to_i,
                message: "Hello world this is my first log message"
              },
            }.to_json

            post_request '/api/v1/storage/store', payload, user

            body = JSON.parse response.body

            expect(body['validation_error']).to_not eql nil
            expect(response.status).to eql 400

          end

          it 'should err if severity is nil;' do

            user_storage

            payload = {
              storage: 'whisper',
              key: 'logs',
              data: {
                severity: nil,
                time: Time.now.to_s,
                message: "Hello world this is my first log message"
              },
            }.to_json

            post_request '/api/v1/storage/store', payload, user

            body = JSON.parse response.body

            expect(body['validation_error']).to_not eql nil
            expect(response.status).to eql 400

          end

        end

        context :time do

          it 'should not err if time is missing' do

            user_storage

            payload = {
              storage: 'whisper',
              key: 'logs',
              data: {
                severity: 2,
                # time: Time.now.to_s,
                message: "Hello world this is my first log message"
              },
            }.to_json

            post_request '/api/v1/storage/store', payload, user

            body = JSON.parse response.body

            expect(body['id']).to_not eql nil
            expect(response.status).to eql 201

          end

          it 'should accept string time' do

            user_storage

            payload = {
              storage: 'whisper',
              key: 'logs',
              data: {
                severity: 2,
                time: Time.now.to_s,
                message: "Hello world this is my first log message"
              },
            }.to_json

            post_request '/api/v1/storage/store', payload, user

            body = JSON.parse response.body

            expect(body['id']).to_not eql nil
            expect(response.status).to eql 201

          end


          it 'should accept integer time' do

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

            expect(body['id']).to_not eql nil
            expect(response.status).to eql 201

          end

          it 'should err if invalid time' do

            user_storage

            payload = {
              storage: 'whisper',
              key: 'logs',
              data: {
                severity: 2,
                time: 'invalid',
                message: "Hello world this is my first log message"
              },
            }.to_json

            post_request '/api/v1/storage/store', payload, user

            body = JSON.parse response.body

            expect(body['validation_error']).to_not eql nil
            expect(response.status).to eql 400

          end

        end

        context :message do

          it 'should err if message is missing' do

            user_storage

            payload = {
              storage: 'whisper',
              key: 'logs',
              data: {
                severity: 2,
                time: Time.now.to_i,
                # message: "Hello world this is my first log message"
              },
            }.to_json

            post_request '/api/v1/storage/store', payload, user

            body = JSON.parse response.body

            expect(body['validation_error']).to_not eql nil
            expect(response.status).to eql 400

          end

          it 'should err if message is blank' do

            user_storage

            payload = {
              storage: 'whisper',
              key: 'logs',
              data: {
                severity: 2,
                time: Time.now.to_i,
                message: ""
              },
            }.to_json

            post_request '/api/v1/storage/store', payload, user

            body = JSON.parse response.body

            expect(body['validation_error']).to_not eql nil
            expect(response.status).to eql 400

          end

        end

      end

    end
  end
end