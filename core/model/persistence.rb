module Cassandra::Persistence

  def create
    return false unless valid? || persisted?
    hash = self.to_h.compact
    
    begin
      self.class.insert_query(self.send(:database), self.class.column_family_name, hash.stringify_keys)
      changes_applied; persist!
      true
    rescue
      false
    end

  end

  def create!
    return false unless valid? || persisted?
    hash = self.to_h.compact

    self.class.insert_query(self.send(:database), self.class.column_family_name, hash.stringify_keys)

    changes_applied; persist!
    true
  end

  def update_where(hash={})
    return false unless valid?

    data = {}

    self.changes.map do |k, v|
      data[k] = v
    end

    begin
      self.class.update_query(self.send(:database), self.class.column_family_name, data.stringify_keys, hash.stringify_keys)
      changes_applied; persist!
      true
    rescue
      false
    end
  end

  def update_where!(hash={})
    return false unless valid?

    data = {}

    self.changes.map do |k, v|
      data[k] = v
    end

    self.class.update_query(self.send(:database), self.class.column_family_name, data.stringify_keys, hash.stringify_keys)
    changes_applied; persist!
    true
  end

  def delete_by(hash={})
    return false unless persisted?
    begin
      self.class.delete_query(self.send(:database), self.class.column_family_name, hash.stringify_keys)
      true
    rescue
      false
    end
  end

  def delete_by!(hash={})
    return false unless persisted?
    self.class.delete_query(self.send(:database), self.class.column_family_name, hash.stringify_keys)
    true
  end

  def persisted?
    return false if @persistence_status == nil
    @persistence_status
  end

  private
  def database
    App.database
  end

  def persist!
    @persistence_status = true
  end

end
