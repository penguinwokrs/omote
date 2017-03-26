# frozen_string_literal: true
class AddColumnToMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :group_f, :string, after: :name_ja
    add_column :menus, :group_e, :string, after: :name_ja
    add_column :menus, :group_d, :string, after: :name_ja
    add_column :menus, :group_c, :string, after: :name_ja
    add_column :menus, :group_b, :string, after: :name_ja
    add_column :menus, :group_a, :string, after: :name_ja
  end
end
