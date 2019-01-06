class ListingsFilter
  attr_reader :sale_status, :bedrooms

  def initialize(listings:, bedrooms: nil, sale_status: nil, year_sold: nil, new_sold_price_since: nil)
    @listings = listings
    @bedrooms = bedrooms
    @sale_status = sale_status
    @year_sold = year_sold
    @new_sold_price_since = new_sold_price_since
  end

  def filter
    bedrooms_filter
    sale_status_filter
    year_sold_filter
    new_sold_price_filter
    @listings.order(created_at: :desc)
  end

  private

  def new_sold_price_filter
    if @new_sold_price_since.present?
      @listings = @listings
        .joins(:sold_prices)
        .where("sold_prices.created_at > ?", @new_sold_price_since.to_i.days.ago)
    end
  end

  def year_sold_filter
    if @year_sold.present?
      @listings = @listings
        .joins(:sold_prices).where("sold_prices.year = ?", @year_sold.to_i)
    end
  end

  def sale_status_filter
    if sold?
      @listings =
        @listings.where(
          "'SOLD STC'=ANY(tags) OR 'UNDER OFFER'=ANY(tags)"
      )
    elsif unsold?
      @listings =
        @listings.where.not(
          "'SOLD STC'=ANY(tags) OR 'UNDER OFFER'=ANY(tags)"
      )
    end
  end

  def bedrooms_filter
    if bedrooms.present?
      @listings = @listings.where("bedrooms = ?", bedrooms)
    end
  end

  def unsold?
    @sale_status == "unsold"
  end

  def sold?
    @sale_status == "sold"
  end
end
