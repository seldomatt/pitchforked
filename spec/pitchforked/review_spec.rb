require 'spec_helper'

describe Review do

  context "with an album" do 
    
    let(:album) do 
      Album.new.tap do |a|
        a.id = 1
        a.name = "Banks"
      end
    end

    subject do 
      Review.new.tap do |r| 
        r.album_id = album.id
      end
    end


    it "find_album should return the review's album" do 
      subject.find_album.should == album
    end
  end


end