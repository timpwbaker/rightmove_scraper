class AddBedroomsToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :bedrooms, :integer
  end
end
