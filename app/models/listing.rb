class Listing < ApplicationRecord
  belongs_to :area
  has_many :prices, dependent: :destroy

  def self.known_delisted
    delisted.where.not(time_delisted: nil)
  end

  def self.unknown_delisted
    delisted.where(time_delisted: nil)
  end

  def self.delisted
    self.where(delisted: true, under_offer: nil)
  end

  def self.under_offer
    self.where.not(under_offer: nil)
  end

  def price
    @_price ||= prices.chronological.last
  end

  def rm_link
    "http://www.rightmove.co.uk/property-for-sale/property-#{self.rightmove_id}.html"
  end

  def self.sold_tags
    ["UNDER OFFER", "SOLD STC"]
  end

  def sold?
    self.tags.any? { |listing_tag| Listing.sold_tags.include?(listing_tag) }
  end
end
