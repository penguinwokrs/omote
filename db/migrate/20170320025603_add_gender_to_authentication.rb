class AddGenderToAuthentication < ActiveRecord::Migration[5.0]
  def change
    add_column :authentications, :gender, :integer, limit: 2
  end
end
