module Cassandra::QueryBuilder

  def insert_query(session, column_family, data)

    session.execute(
      "INSERT INTO #{column_family} (#{data.keys.join(',')}) VALUES (#{q_mark(data.size)});", arguments: data.values
    )

  end


  def update_query(session, column_family, data, where)

    session.execute(
      "UPDATE #{column_family} SET #{update_args(data)} WHERE #{update_args_where(where)}",
      arguments: update_arguments(data, where)
    )

  end


  def select_query(session, column_family, where, order_by = nil, order_type = nil, limit = nil)

    if order_by && limit
      session.execute(
        "SELECT * FROM #{column_family} WHERE #{select_args(where)} ORDER BY #{order_by} #{order_type || 'DESC'} LIMIT #{limit.to_i}", arguments: where
      )
    elsif order_by && !limit
      session.execute(
        "SELECT * FROM #{column_family} WHERE #{select_args(where)} ORDER BY #{order_by} #{order_type || 'DESC'}", arguments: where
      )
    elsif !order_by && limit
      session.execute(
        "SELECT * FROM #{column_family} WHERE #{select_args(where)} LIMIT #{limit.to_i}", arguments: where
      )
    elsif !order_by && !limit
      session.execute(
        "SELECT * FROM #{column_family} WHERE #{select_args(where)}", arguments: where
      )
    end

  end

  def delete_query(session, column_family, where)

    session.execute(
      "DELETE FROM #{column_family} WHERE #{delete_args(where)};", arguments: where.values
    )

  end

  private
  def q_mark(n)
    ('?, ' * (n - 1)) + '?'
  end

  # Question Mark with equal sign
  def q_mark_e(n)
    ('? = ?, ' * (n - 1)) + '? = ?'
  end

  def update_arguments(data, where)
    data.merge(where).values
  end

  def update_args(data)
    str = ''

    data.keys.each do |e|
      str = str + (e + '= ?,')
    end

    str.sub(/.{1}$/,'')
  end


  def update_args_where(data)
    str = ''

    data.keys.each do |e|
      str = str + (e + '= ? AND ')
    end

    str.sub(/.{5}$/,'')
  end

  def select_args(data)
    str = ''

    data.keys.each do |e|
      str = str + (e + '= ?,')
    end

    str.sub(/.{1}$/,'')
  end

  def delete_args(data)
    str = ''

    data.keys.each do |e|
      str = str + (e + '= ?,')
    end

    str.sub(/.{1}$/,'')
  end

end