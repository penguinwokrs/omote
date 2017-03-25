# frozen_string_literal: true
class CreateGivers < ActiveRecord::Migration[5.0]
  def change
    create_table :givers do |t|
      t.string :giver_id
      t.string :image
      t.string :name_kanji
      t.string :nama_hira
      t.string :giver_category
      t.text :comment
      t.string :area
      t.text :biography
      t.timestamps
    end
  end
end
