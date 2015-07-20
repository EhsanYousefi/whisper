class User

  include Cassandra::ColumnFamily
  include ActiveModel::SecurePassword
  include Helpers::User

  columns :email, :auth_token, :password_digest, :first_name, :last_name, :company, :apps

  has_secure_password

  validates :email,       presence: true, type: String, format: {with: /@/, message: 'is incorrect' }, uniq: true
  validates :auth_token,  presence: true, type: String
  validates :first_name,  presence: true, type: String
  validates :last_name,   presence: true, type: String
  validates :company,     type: String

end

#x  = User.new(first_name: "ehsan", last_name: "yousefi", email: "ehsna.gfdf@live.com", password: "dfdf", auth_token: "dfdfdf")
# { voyager: [{key: 'logs', structure: {name: { type: "string", presence: "true"}}}]}
#
# voyager:
#   logs: {
#     name: { type: },
#     main: { type;}
# }
# }
#
# CREATE TYPE app(
#
#     )