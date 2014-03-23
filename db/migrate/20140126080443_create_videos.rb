class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.datetime :originally_posted
      t.string :url
      t.string :direct_url
      t.string :site

      t.timestamps
    end
  end
end
