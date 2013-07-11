class AddCollumnToFxtrends < ActiveRecord::Migration
  def change
    add_column :fxtrends, :kind, :string
  end
end
