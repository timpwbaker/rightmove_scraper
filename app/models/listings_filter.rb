class ListingsFilter
  attr_reader :listings, :bedrooms

  def initialize(listings:, bedrooms: nil)
    @listings = listings
    @bedrooms = bedrooms
  end

  def filter
    if bedrooms
      listings.where(bedrooms: bedrooms)
    else
      listings
    end
  end

  def bedroom_filter
    if bedrooms
      listings = listings.where(bedrooms: bedrooms)
    end
  end
end
