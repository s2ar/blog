class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
  		t.string :title
  		t.text :description, :default => false
  		t.boolean :enable  	
        t.timestamps
    end
  end
end
