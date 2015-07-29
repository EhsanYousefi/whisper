require 'spec_helper'

describe CreateStorageController do

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
    storage = build(:storage, user_name: user.user_name)
    storage.create!
    storage
  end

  describe 'Create User Storage' do

    it 'should create User Storage' do

      expect(Storage.all.first).to eql nil

      expect(CreateColumnFamily).to receive :create_storage_successful

      payload = {
        name: 'voyager',
        key: 'logs',
        structure: {
          severity: {
            type: 'integer',
            presence: 'true',
            searchable: 'true'
          },
          time: {
            type: 'integer',
            presence: 'true',
            searchable: 'true'
          },
          message: {
            type: 'string',
            presence: 'true',
            searchable: 'true'
          }
        }
      }

      post_request '/api/v1/storage/create', payload.to_json, user

      body = JSON.parse response.body
      binding.pry
      expect(Storage.all.first).to_not eql nil
      expect(response.status).to eql 201

    end

    context :failuers do

      context :name do

        it 'should err if missing' do

          payload = {
            key: 'logs',
            structure: {
              severity: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'

              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(Storage.all.first).to eql nil
          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'name'

        end

        it 'should err if blank' do

          payload = {
            name: '',
            key: 'logs',
            structure: {
              severity: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(Storage.all.first).to eql nil
          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'name'

        end


        it 'should err if invalid' do

          payload = {
          name: '*invalid',
          key: 'logs',
          structure: {
          severity: {
          type: 'integer',
          presence: 'true',
          searchable: 'true'
          },
          time: {
          type: 'integer',
          presence: 'true',
          searchable: 'true'
          },
          message: {
          type: 'string',
          presence: 'true',
          searchable: 'true'
          }
          }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(Storage.all.first).to eql nil
          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'name'

        end

      end

      context :key do

        it 'should err if missing' do

          payload = {
            name: 'voyager',
            structure: {
              severity: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'key'

        end

        it 'should err if blank' do

          payload = {
            name: 'voyager',
            key: '',
            structure: {
              severity: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'key'

        end

        it 'should err if invalid' do

          payload = {
          name: 'voyager',
          key: '%invalid',
          structure: {
          severity: {
          type: 'integer',
          presence: 'true',
          searchable: 'true'
          },
          time: {
          type: 'integer',
          presence: 'true',
          searchable: 'true'
          },
          message: {
          type: 'string',
          presence: 'true',
          searchable: 'true'
          }
          }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'key'

        end

      end

      context :structure do

        it 'should err if missing' do


          payload = {
            name: 'voyager',
            key: 'logs',
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure - > type is missing' do

          payload = {
            name: 'voyager',
            key: 'logs',
            structure: {
              severity: {
                presence: 'true',
                searchable: 'true'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure - > type is invalid' do

          payload = {
            name: 'voyager',
            key: 'logs',
            structure: {
              severity: {
                type: 'integers',
                presence: 'true',
                searchable: 'true'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end


        it 'should err if structure - > presence is invalid' do

          payload = {
            name: 'voyager',
            key: 'logs',
            structure: {
              severity: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              time: {
                type: 'integer',
                presence: 'sdfdsf',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure - > presence is missing' do

          payload = {
            name: 'voyager',
            key: 'logs',
            structure: {
              severity: {
                type: 'integer',
                searchable: 'true'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure - > searchable is missing' do

          payload = {
            name: 'voyager',
            key: 'logs',
            structure: {
              severity: {
                type: 'integer',
                presence: 'true'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure - > searchable is invalid' do

          payload = {
            name: 'voyager',
            key: 'logs',
            structure: {
              severity: {
                type: 'integer',
                presence: 'true',
                searchable: 'invalid'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure - > searchable == true and structure -> presence == false' do

          payload = {
            name: 'voyager',
            key: 'logs',
            structure: {
              severity: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },

              time: {
                type: 'integer',
                presence: 'false',
                searchable: 'true'
              },

              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

      end

      context :uniqueness do

        it 'should err if is not uniq' do
          user_storage

          expect(CreateColumnFamily).to_not receive :create_storage_successful

          payload = {
            name: user_storage.name,
            key:  user_storage.key,
            structure: {
              severity: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              time: {
                type: 'integer',
                presence: 'true',
                searchable: 'true'
              },
              message: {
                type: 'string',
                presence: 'true',
                searchable: 'true'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400

        end
      end

    end
  end
end