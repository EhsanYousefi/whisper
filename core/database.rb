require 'cassandra'

module Core::Database

  def self.included(target)
    target.extend ClassMethods
  end

  class InvalidDatabaseConfiguration < StandardError; end

  def database
    @database ||= self.class.database
  end

  module ClassMethods

    def database
      @@database ||= init_db!
    end

    private

    def init_db!
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

end