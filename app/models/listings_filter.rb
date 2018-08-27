class ListingsFilter
  attr_reader :sale_status, :bedrooms

  def initialize(listings:, bedrooms: nil, sale_status: nil)
    @listings = listings
    @bedrooms = bedrooms
    @sale_status = sale_status
  end

  def filter
    bedrooms_filter
    sale_status_filter
    @listings.order(created_at: :desc).includes(:prices)
  end

  private

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
