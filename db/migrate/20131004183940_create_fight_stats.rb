class CreateFightStats < ActiveRecord::Migration
  def change
    create_table :fight_stats do |t|
      t.integer :winner
      t.datetime :date
      t.boolean :isFinished

      t.timestamps
    end
  end
end
