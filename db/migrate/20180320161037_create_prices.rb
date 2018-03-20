class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.references :listing, foreign_key: true
      t.date :date
      t.integer :amount
      t.boolean :reduction

      t.timestamps
    end
  end
end
