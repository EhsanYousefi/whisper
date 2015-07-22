# require 'spec_helper'
#
# describe GetDataFromStorageController do
#
#   let :email do
#     "roundtableapps@gmail.com"
#   end
#
#   let :user do
#     binding.pry
#     user = build(:user, email: email)
#     user.create!
#     user
#   end
#
#   describe 'Get Data From Stroage' do
#
#     it 'should fetch data from storage' do
#
#       payload = {
#           storage: 'whisper',
#           key: 'logs',
#           between: [Time.now, Time.now],
#           where: {
#             name: 2,
#             loa: 5
#           }
#
#       post_request '/api/v1/storage/data/fetch'
#     end
#
#   end
#
# end