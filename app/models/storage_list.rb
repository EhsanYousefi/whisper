class StorageList

  include Cassandra::ColumnFamily

  columns(
    user_name:   { type: String },
    key:         { type: String },
    description: { type: String }
  )

  validates :user_name,   presence: true, format: { without: /\W/, message: 'is incorrect' }
  validates :key,         presence: true, format: { without: /\W/, message: 'is incorrect' }, uniq_with: [:user_name]

end
