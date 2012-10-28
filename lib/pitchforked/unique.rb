module Unique

  module ClassMethods

    def include?(name)
      if self.all.select{|o| o.name == name}.empty?
        false
      else
        true
      end
    end

    def find(name)
      self.all.select {|o| o.name == name }.first
    end

    def create_unique(name)
      if self.include?(name)
        self.find(name)
      else
        self.new.tap{|o| o.name = name}
      end
    end


  end

  module InstanceMethods

    def primary_key_iterator
      self.class.all.length 
    end

  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end

end