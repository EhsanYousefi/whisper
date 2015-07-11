require 'spec_helper'

describe UserAuthenticationController do

  before :each do
    clean_database('User')
  end

  let :user do
    user = build :user
    user.create!
    user
  end

  describe 'Authenticate User' do

    it 'should authenticate user' do
      binding.pry
    end

  end

end