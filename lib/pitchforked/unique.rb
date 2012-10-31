module Unique
  
  def include?(name)
    if self.all.select{|o| o.name == name}.empty?
      false
    else
      true
    end
  end

  def find_by_name(name)
    self.all.detect {|o| o.name == name }
  end

  def create_unique(name)
    if self.include?(name)
      self.find_by_name(name)
    else
      self.new.tap do |o| 
        o.name = name
      end
    end
  end

end

