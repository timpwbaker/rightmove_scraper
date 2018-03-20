class CreateAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :areas do |t|
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
