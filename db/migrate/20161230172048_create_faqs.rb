# frozen_string_literal: true
class CreateFaqs < ActiveRecord::Migration[5.0]
  def change
    create_table :faqs do |t|
      t.string :question
      t.text :answer
      t.string :category
      t.timestamps
    end
  end
end
