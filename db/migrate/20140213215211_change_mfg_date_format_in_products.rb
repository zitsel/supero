class ChangeMfgDateFormatInProducts < ActiveRecord::Migration
  def change
      change_column :products, :mfg_date, :string
  end
end
