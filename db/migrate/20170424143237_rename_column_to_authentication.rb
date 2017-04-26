class RenameColumnToAuthentication < ActiveRecord::Migration[5.0]
  def change
    rename_column :authentications, :dob, :birth
  end
end
