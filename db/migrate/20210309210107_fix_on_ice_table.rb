class FixOnIceTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :on_ice, :on_ices
  end
end
