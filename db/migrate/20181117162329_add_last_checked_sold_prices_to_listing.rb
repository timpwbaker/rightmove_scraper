class AddLastCheckedSoldPricesToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :last_checked_sold_prices, :datetime
  end
end
