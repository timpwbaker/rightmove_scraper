class AddAreaIdToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :area_id, :integer
  end
end
