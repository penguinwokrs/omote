# frozen_string_literal: true
class CreateInterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :interviews do |t|
      t.string :name
      t.text :contents
      t.timestamps
    end
  end
end
