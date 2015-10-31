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
        sort: 'asc',
        structure: {
          severity: {
            type: 'integer',
            required: true,
            index: true
          },
          time: {
            type: 'time',
            required: true
          },
          description: {
            type: 'text'
          },
          message: {
            type: 'text',
            default: 'mikel'
          }
        }
      }

      post_request '/api/v1/storage/create', payload.to_json, user

      body = JSON.parse response.body

      expect(Storage.all.first).to_not eql nil
      expect(response.status).to eql 201

      # # Make Sure Database Is Cleaned
      # begin
      #   App.database.execute("DROP TABLE #{Storage.all.first.column_family_name}");
      # rescue
      #   true
      # end

    end

    context :failuers do

      context :reserved_words do

        it 'should err if structure column family name is reserved by cassandra' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              where: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(Storage.all.first).to eql nil
          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'reserved'

        end

      end

      context :name do

        it 'should err if missing' do

          payload = {
            # name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
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
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
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
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
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
            # key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
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
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
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
            key: '#invalid',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
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

      context :sort do

        it 'should err if missing' do

          payload = {
            name: 'voyager',
            key: 'users',
            # sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'sort'

        end

        it 'should err if value is not asc|desc' do

          payload = {
            name: 'voyager',
            key: 'users',
            sort: 'invalid',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'sort'

        end

      end

      context :structure do

        it 'should err if missing' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            # structure: {
            #   severity: {
            #     type: 'integer',
            #     required: true,
            #     index: true,
            #     default: 2
            #   },
            #   time: {
            #     type: 'time',
            #     required: true
            #   },
            #   description: {
            #     type: 'text'
            #   },
            #   message: {
            #     type: 'text',
            #     required: true,
            #     default: 'mikel'
            #   }
            # }
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
            sort: 'asc',
            structure: {
              severity: {
                # type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
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
            sort: 'asc',
            structure: {
              severity: {
                type: 'invalid',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'invalid',
                default: 'mikel'
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
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: 'invalid',
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure - > index is invalid' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: 'invalid'
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> index used more than 1 time' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'string',
                index: true
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }

          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> index used with text type' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text',
                index: true
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> index used with map type' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'map',
                index: true
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> index used with array type' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'array',
                index: true
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default used with required' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'integer',
                required: true,
                index: true,
                default: 2
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default used with `timeuuid` type' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'time_uuid',
                index: true,
                default: 2
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default used with `uuid` type' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'uuid',
                index: true,
                default: 2
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default used with `time` type' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'time',
                index: true,
                default: 2
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default value type is not matched with structure -> type |integer, string|' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                default: 2
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'integer',
                index: true,
                default: 'hello' #default should be integer in this case but is not
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default value type is not matched with structure -> type |string, integer|' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                default: 2
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'string',
                index: true,
                default: 2 #default should be integer in this case but is not
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default value type is not matched with structure -> type |map, integer|' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                default: 2
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'map',
                default: 2 #default should be integer in this case but is not
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default value type is not matched with structure -> type |array, integer|' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                default: 2
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'array',
                default: 2 #default should be integer in this case but is not
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default value type is not matched with structure -> type |float, integer|' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                default: 2
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'float',
                default: 2 #default should be integer in this case but is not
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default value type is not matched with structure -> type |text, integer|' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                default: 2
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text',
                default: 2 #default should be integer in this case but is not
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default value type is not matched with structure -> type |ip, integer|' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                default: 2
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'ip',
                default: 2 #default should be integer in this case but is not
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default with type `map` values not string' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                default: 2
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'map',
                default: {multi: {m: 's'}}
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end

        it 'should err if structure -> default with type `array` values not string' do

          payload = {
            name: 'voyager',
            key: 'logs',
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                default: 2
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'array',
                default: ['stirng', 1]
              },
              message: {
                type: 'text',
                default: 'mikel'
              }
            }
          }


          post_request '/api/v1/storage/create', payload.to_json, user

          body = JSON.parse response.body

          expect(response.status).to eql 400
          expect(body.to_s).to include 'validation_error'
          expect(body.to_s).to include 'structure'

        end


        # it 'should err if structure - > index == true and structure -> presence == false' do

          # payload = {
          #   name: 'voyager',
          #   key: 'logs',
          #   structure: {
          #     severity: {
          #       type: 'integer',
          #       presence: true,
          #       searchable: true
          #     },
          #
          #     time: {
          #       type: 'integer',
          #       presence: false,
          #       searchable: true
          #     },
          #
          #     message: {
          #       type: 'string',
          #       presence: true,
          #       searchable: true
          #     }
          #   }
          # }

        #   post_request '/api/v1/storage/create', payload.to_json, user
        #
        #   body = JSON.parse response.body
        #
        #   expect(response.status).to eql 400
        #   expect(body.to_s).to include 'validation_error'
        #   expect(body.to_s).to include 'structure'
        #
        # end

      end

      context :uniqueness do

        it 'should err if is not uniq' do
          user_storage

          expect(CreateColumnFamily).to_not receive :create_storage_successful

          payload = {
            name: user_storage.name,
            key: user_storage.key,
            sort: 'asc',
            structure: {
              severity: {
                type: 'integer',
                required: true,
                index: true
              },
              time: {
                type: 'time',
                required: true
              },
              description: {
                type: 'text'
              },
              message: {
                type: 'text',
                default: 'mikel'
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
