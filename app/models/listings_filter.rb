class ListingsFilter
  attr_reader :not_sold, :bedrooms

  def initialize(listings:, bedrooms: nil, not_sold: nil)
    @listings = listings
    @bedrooms = bedrooms
    @not_sold = not_sold
  end

  def filter
    bedrooms_filter
    not_sold_filter
    @listings.order(created_at: :desc).includes(:prices)
  end

  def not_sold_filter
    if not_sold
      @listings = @listings.select{ |l| (l.tags & ["SOLD STC", "UNDER_OFFER"]).empty? }
    end
  end

  def bedrooms_filter
    if bedrooms
      @listings = @listings.where(bedrooms: bedrooms)
    end
  end
end
