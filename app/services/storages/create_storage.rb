class CreateStorage
  include Wisper::Publisher

  def execute(attributes)
    # Prevent From Mass Assignment
    storage = Storage.new(
      user_name:              attributes[:user_name],
      name:                   attributes[:name],
      key:                    attributes[:key],
      sort:                   attributes[:sort],
      structure:              preapre_structure(attributes[:structure]),
      pattern:                attributes[:pattern],
      column_family_name: (
      (
        (attributes[:user_name] + '_' + attributes[:name] + '_' + attributes[:key])
      ) if attributes[:user_name] && attributes[:name] && attributes[:key] )
    )

    if storage.create
      broadcast(:create_storage_successful, storage)
    else
      broadcast(:create_storage_failed, storage)
    end

  end

  private
  def preapre_structure(structure)
    return unless structure
    structure['ca'] = { type: 'sexy_date' } # ca will be our primary key
    structure['id'] = { type: 'time_uuid' } # timeuuid will be our clustering key
    structure
  end


end
