class Listing < ApplicationRecord
  belongs_to :area
  has_many :prices, dependent: :destroy

  def price
    prices.chronological.last
  end

  def rm_link
    "http://www.rightmove.co.uk/property-for-sale/property-#{self.rightmove_id}.html"
  end
end
