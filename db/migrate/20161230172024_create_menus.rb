# frozen_string_literal: true
class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :name_en
      t.string :name_ja
      t.string :image_square
      t.string :image_rectangle
      t.timestamps
    end
  end
end
