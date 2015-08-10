class User

  include Cassandra::ColumnFamily
  include ActiveModel::SecurePassword
  include Helpers::User

  columns(
    user_name:       { type: String },
    email:           { type: String },
    auth_token:      { type: String },
    password_digest: { type: String },
    first_name:      { type: String },
    last_name:       { type: String },
    company:         { type: String }
  )

  has_secure_password
  validates :user_name,              presence: true, uniq: true
  validates :user_name,              format: { without: /\W/, message: 'is incorrect' }, unless: -> {user_name.blank?}
  validates :email,                  presence: true, uniq: true
  validates :email,                  format: { with: /@/, message: 'is incorrect' }, unless: -> {email.blank?}
  validates :auth_token,             presence: true
  validates :first_name,             presence: true
  validates :last_name,              presence: true
  validates :password_confirmation,  presence: true
  # validates :company

end
