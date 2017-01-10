class AddColumnToGiver < ActiveRecord::Migration[5.0]
  def change
  	add_column :givers, :title, :string, :after => :giver_category
  	add_column :givers, :type, :string, :after => :giver_category
  	add_column :givers, :class, :string, :after => :giver_category
  end
end
