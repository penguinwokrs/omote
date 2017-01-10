class CreatePricelists < ActiveRecord::Migration[5.0]
  def change
    create_table :pricelists do |t|
    	t.string :category
    	t.string :class
    	t.integer :group_a
    	t.integer :group_b
    	t.integer :group_c
    	t.integer :group_d
    	t.integer :group_e
    	t.integer :group_f
      t.timestamps
    end
  end
end
