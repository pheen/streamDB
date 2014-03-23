class AddSportToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :sport, :string
  end
end
