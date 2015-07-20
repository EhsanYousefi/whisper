namespace :cassandra do

  desc "Setup Database For Development Environment"

  task :setup do
    session.execute("
    CREATE KEYSPACE #{App.name}
      WITH replication = {
        'class': 'SimpleStrategy',
        'replication_factor': 3
      };"
    )

    puts "'#{App.name}' Keyspace successfully Created!"
  end

  def session
    init_session!
  end

  def init_session!
    validate_db_config(load_db_config)
    cluster = Cassandra.cluster(username: load_db_config['user'], password: load_db_config['password'], hosts: [load_db_config['ip']] )
    cluster.connect
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
