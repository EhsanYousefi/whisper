class Hash

  def compact
    delete_if {|k,v| v.compact if v.is_a?(Hash); v.nil? }
  end

end