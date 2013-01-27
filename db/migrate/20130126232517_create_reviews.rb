class CreateReviews < ActiveRecord::Migration
  def change 
    create_table :reviews do |t|
     t.string :url
     t.decimal :rating, :precision => 4, :scale => 2
     t.integer :bnm
     t.integer :year
     t.string :author
     t.text :body
     t.integer :album_id
  end
  end
end
