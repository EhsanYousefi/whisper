class User

  include Cassandra::ColumnFamily
  include ActiveModel::SecurePassword
  include Helpers::User

  columns(
    user_name:       String,
    email:           String,
    auth_token:      String,
    password_digest: String,
    first_name:      String,
    last_name:       String,
    company:         String
  )

  has_secure_password

  validates :user_name,   presence: true, format: { without: /\W/, message: 'is incorrect' }, uniq: true
  validates :email,       presence: true, format: { with: /@/, message: 'is incorrect' },     uniq: true
  validates :auth_token,  presence: true
  validates :first_name,  presence: true
  validates :last_name,   presence: true
  # validates :company

end