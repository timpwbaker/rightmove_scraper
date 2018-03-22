class AddTagsToListing < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :tags, :text, array: true, default: []
  end
end
