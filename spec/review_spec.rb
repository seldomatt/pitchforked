require_relative '../review'

describe Review do 

  subject  do 
    Review.new.tap do |r|
      r.id = 1
      r.url = "http://www.pitchfork.com/review/albums/1762-banks/"
      r.rating = 8.2
      r.year = 2012
      r.author = "Steven Hyden"
      r.body = "BLah Blah"
      r.album_id = 1
    end
  end

  its(:id)    { should == 1}
  its(:url)   { should == "http://www.pitchfork.com/review/albums/1762-banks/" }
  its(:rating)  { should == 8.2 }
  its(:year)  { should == 2012 }
  its(:author)  { should == "Steven Hyden"}
  its(:body)  { should == "BLah Blah"}
  its(:album_id) { should == 1}


end