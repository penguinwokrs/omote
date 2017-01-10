class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
    	t.string :category
    	t.string :header
    	t.string :body
      t.timestamps
    end
  end
end
