class AddCollumnToFxtrends < ActiveRecord::Migration
  def change
    add_column :fxtrends, :type, :string
  end
end
