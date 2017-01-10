class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
    	t.string :category
    	t.string :header
    	t.string :body
    	t.string :link
      t.timestamps
    end
  end
end
