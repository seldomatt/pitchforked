require 'spec_helper'

describe Album do 

  subject do 
    Album.new.tap do |a|
      a.id = 1
      a.name = "Banks"
      a.artist_id = 1
      a.label_id = 1
    end

  end

  its(:id)    { should == 1 }
  its(:name)  { should == "Banks"}
  its(:artist_id) { should == 1 }
  its(:label_id)  { should == 1 }

end