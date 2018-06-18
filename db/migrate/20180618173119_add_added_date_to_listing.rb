class AddAddedDateToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :added_date, :datetime
  end
end
