class CreateColumnFamily

  def self.create_storage_successful(storage)
    storage = self.prepare_storage(storage)

    App.database.execute(
      "CREATE TABLE #{storage['column_family_name']} (
        #{
          self.prepare_table_info(
          self.extract_column_names_and_types(storage['structure']),
          self.extract_clustering_keys(storage['structure']))
        }
      )"
    )

  end

  private

  def self.prepare_storage(storage)
    storage = storage.to_h
    storage['structure']['id'] = { type: 'timeuuid' }
    storage
  end

  def self.extract_column_names_and_types(structure)

    structure.map do |k,v|
      "#{k} #{CassandraTypeMapper.get_type(v.to_h['type'])},"
    end.join('')

  end

  # c_n_t means column names and tyoes
  def self.extract_clustering_keys(structure)

    clustering_keys = []
    structure.each do |k,v|
      (clustering_keys << k) if v.to_h['searchable'] == 'true'
    end

    "PRIMARY KEY ((id), #{clustering_keys.join(',')})"
  end

  def self.prepare_table_info(columns, primary_key)
    columns + primary_key
  end

end
