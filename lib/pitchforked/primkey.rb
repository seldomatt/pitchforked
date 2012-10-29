module PrimKey

  def primary_key_iterator
    self.class.all.length 
  end

end