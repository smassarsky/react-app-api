class RemovePlayerCodeStatus < ActiveRecord::Migration[6.0]
  def change
    remove_column :player_codes, :status
  end
end
