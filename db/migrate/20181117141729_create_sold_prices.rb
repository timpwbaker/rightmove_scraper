class CreateSoldPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :sold_prices do |t|
      t.references :listing, foreign_key: true
      t.integer :year
      t.integer :amount

      t.timestamps
    end

    add_index :sold_prices, [:listing_id, :year, :amount], :unique => true
  end
end
