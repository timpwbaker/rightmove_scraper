class AddNoLongerListedData < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :delisted, :boolean, default: false
    add_column :listings, :time_delisted, :datetime
  end
end
