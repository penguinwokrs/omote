class CreateGlobalNavis < ActiveRecord::Migration[5.0]
  def change
    create_table :global_navis do |t|
      t.string :item_ja
      t.string :item_en
      t.string :url
      t.timestamps
    end
  end
end
