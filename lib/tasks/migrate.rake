namespace :cassandra do

  desc "Cassandra Migration Env"

  task :migration do
    # Access to database session with : database
    # Schema method: create_column_family(database); drop_column_family(database)
    binding.pry
  end

  def database
    init_session!
  end

  def init_session!
    validate_db_config(load_db_config)
    cluster = Cassandra.cluster(username: load_db_config['user'], password: load_db_config['password'], hosts: [load_db_config['ip']] )
    cluster.connect(load_db_config['keyspace'])
  end

  def load_db_config
    config ||= YAML.load_file(App.root.join('config', 'yaml', 'cassandra.yml'))[App.environment.to_s]
  end

  def validate_db_config(config)

    if (
    config['user'].blank? ||
      config['password'].blank? ||
      config['ip'].blank? ||
      config['keyspace'].blank?
    ) then raise InvalidDatabaseConfiguration
    end

  end

end
