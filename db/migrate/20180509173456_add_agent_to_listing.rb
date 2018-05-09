class AddAgentToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :agent, :string
  end
end
