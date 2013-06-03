class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
  		t.string :title
  		t.text :annot
  		t.text :description
  		t.boolean :enable, :default => false
        t.timestamps
    end
    add_index(:posts, :title)
  end
end
