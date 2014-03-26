class AddEtsyPositionToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :etsy_position, :integer
  end
end
