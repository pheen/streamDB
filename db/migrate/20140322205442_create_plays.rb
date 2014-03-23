class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.integer :user_id
      t.integer :video_id
      t.integer :play_count

      t.timestamps
    end
  end
end
