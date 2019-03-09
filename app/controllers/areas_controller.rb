class AreasController < ApplicationController
  before_action :set_area, only: [:show]
  before_action :set_listings, only: [:show]

  def index
    @areas = Area.all
  end

  def show
    @filtered_ids ||= ListingsFilter.new(
      listings: @listings,
      bedrooms: filter_params[:bedrooms],
      sale_status: filter_params[:sale_status],
      year_sold: filter_params[:year_sold],
      new_sold_price_since: filter_params[:new_sold_price_since]
    ).filter.map(&:id)
    @filtered_listings ||=
      Listing.where(id: @filtered_ids).order(order_by).includes(:sold_prices, :prices)
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      redirect_to @area, notice: 'Area was successfully created.'
    else
      render :new
    end
  end

  private

  def order_by
    filter_params[:order_by] || :id
  end

  def set_area
    @area = Area.find(params[:id])
  end

  def set_listings
    @listings = @area.listings.includes(:sold_prices, :prices)
  end

  def area_params
    params.require(:area).permit(:url, :name, :bedrooms)
  end

  def filter_params
    params.permit(:bedrooms, :sale_status, :year_sold, :new_sold_price_since, :order_by)
  end
end
