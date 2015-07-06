class User
  include Cassandra::ColumnFamily

  columns :email, :password, :first_name, :last_name, :company

  validates :email,       presence: true, type: String
  validates :password,    presence: true, type: String
  validates :first_name,  presence: true, type: String
  validates :last_name,   presence: true, type: String
  validates :company,     presence: true, type: String

end