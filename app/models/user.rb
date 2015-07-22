class User

  include Cassandra::ColumnFamily
  include ActiveModel::SecurePassword
  include Helpers::User

  columns :user_name, :email, :auth_token, :password_digest, :first_name, :last_name, :company, :apps

  has_secure_password

  validates :user_name,   presence: true, type: String, format: { without: /\W/, message: 'is incorrect' }, uniq: true
  validates :email,       presence: true, type: String, format: { with: /@/, message: 'is incorrect' },     uniq: true
  validates :auth_token,  presence: true, type: String
  validates :first_name,  presence: true, type: String
  validates :last_name,   presence: true, type: String
  validates :company,     type: String

end