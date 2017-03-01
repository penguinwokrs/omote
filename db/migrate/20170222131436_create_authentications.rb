# frozen_string_literal: true
class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.string :name
      t.date :dob
      t.references :prefecture
      t.string :address
      t.integer :trust_dock_id
      t.integer :status, default: 0, null: false
      t.string :denied_reason

      t.timestamps
    end
  end
end
