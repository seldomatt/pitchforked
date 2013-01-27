class CreateAlbums < ActiveRecord::Migration
  def change 
    create_table :albums do |t|
      t.string :name
      t.integer :artist_id
      t.integer :label_id
    end
  end
end
