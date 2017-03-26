class AddMessageIdToAuthentication < ActiveRecord::Migration[5.0]
  def change
    add_column :authentications, :message_id, :string, default: ''
  end
end
