class CreateFxtrends < ActiveRecord::Migration
  def change
    create_table :fxtrends do |t|
    	t.string :pamm
    	t.date :date
    	t.string :percent
    	t.timestamps
    end 
  end
end
