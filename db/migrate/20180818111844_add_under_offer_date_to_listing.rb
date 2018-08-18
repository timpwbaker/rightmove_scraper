class AddUnderOfferDateToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :under_offer, :datetime
  end
end
