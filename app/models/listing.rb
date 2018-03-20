class Listing < ApplicationRecord
  belongs_to :area
  has_many :prices, dependent: :destroy

  def price
    prices.chronological.last
  end
end
