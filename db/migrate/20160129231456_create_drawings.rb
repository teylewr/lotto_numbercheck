class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.integer :game_id
      t.integer :pick_one
      t.integer :pick_two
      t.integer :pick_three
      t.integer :pick_four
      t.integer :pick_five
      t.integer :pick_six
      t.integer :bonus_one
      t.integer :bonus_two
      t.datetime :draw_date

      t.timestamps
    end
  end
end
