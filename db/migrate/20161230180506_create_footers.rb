class CreateFooters < ActiveRecord::Migration[5.0]
  def change
    create_table :footers do |t|
      t.string :category
      t.string :item_ja
      t.string :item_en
      t.string :url
      t.timestamps
    end
  end
end
