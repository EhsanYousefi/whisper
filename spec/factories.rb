require 'factory_girl'
FactoryGirl.define do

  factory :user do |u|

    u.sequence :user_name do |u|
      "username#{u}"
    end

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

  factory :storage do |u|

    u.user_name { user.user_name }

    u.sequence :name do |n|
      "name#{n}"
    end

    u.sequence :key do |k|
      "key#{k}"
    end
    u.sort 'desc'

    u.column_family_name 'test_column_family_name'

    u.structure(
      {
        field:   {type: 'integer'},
        field_2:   {type: 'integer', default: 2, index: true}
      }
    )

  end

end
