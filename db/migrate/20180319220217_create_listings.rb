class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.integer :price
      t.text :address
      t.date :added_on
      t.date :reduced_on
      t.integer :rightmove_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
