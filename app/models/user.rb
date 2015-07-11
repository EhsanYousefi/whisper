class User

  include Cassandra::ColumnFamily
  include ActiveModel::SecurePassword
  include Helpers::User

  columns :email, :auth_token, :password_digest, :first_name, :last_name, :company

  has_secure_password

  validates :email,       presence: true, type: String, uniq: true
  validates :auth_token,  presence: true, type: String
  # validates :password,    presence: true, type: String
  validates :first_name,  presence: true, type: String
  validates :last_name,   presence: true, type: String
  validates :company,     presence: true, type: String

end