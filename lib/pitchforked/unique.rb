module Unique
  
  def include?(name)
    if self.all.select{|o| o.name == name}.empty?
      false
    else
      true
    end
  end

  def find(name)
    self.all.detect {|o| o.name == name }
  end

  def create_unique(name)
    if self.include?(name)
      self.find(name)
    else
      self.new.tap{|o| o.name = name}
    end
  end

end

