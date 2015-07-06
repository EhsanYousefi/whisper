module Core::Info

  def self.included(target)
    target.extend ClassMethods
  end

  def name
    @name ||= YAML.load_file(App.root.join('config', 'yaml', 'info.yml'))['name']
  end

  def root
    @root ||= Pathname.new(File.expand_path('../../', __FILE__))
  end

  def set_instance
    self.class.get_instance = self
  end

  module ClassMethods
    attr_accessor :get_instance

    def root
      @@root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end

    def name
      @@name ||= YAML.load_file(App.root.join('config', 'yaml', 'info.yml'))['name']
    end

  end

end
