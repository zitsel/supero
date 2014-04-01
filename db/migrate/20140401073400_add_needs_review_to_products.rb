class AddNeedsReviewToProducts < ActiveRecord::Migration
  def change
    add_column :products, :needs_review, :boolean
  end
end
