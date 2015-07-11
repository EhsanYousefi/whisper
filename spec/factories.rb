require 'factory_girl'
FactoryGirl.define do

  factory :user do |u|

    u.sequence :email do |e|
      "roundtableapps#{e}@gmail.com"
    end

    u.sequence :auth_token do |a|
      "DKMFKDXFM#{a}DFKDKD#{a}"
    end

    u.password 'password'
    u.password_confirmation 'password'

    u.sequence :first_name do |f|
      "FirstName#{f}"
    end

    u.sequence :last_name do |l|
      "LastName#{l}"
    end

    u.company "roundtableapps"

  end

end