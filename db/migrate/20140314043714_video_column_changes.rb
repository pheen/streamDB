class VideoColumnChanges < ActiveRecord::Migration
  def change
    add_column :videos, :thumbnail, :string
    rename_column :videos, :site, :post_url
    rename_column :videos, :originally_posted, :post_date
  end
end
