class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  def index
    @areas = Area.all
  end

  def show
    @filtered_listings = ListingsFilter.new(
      listings: @area.listings.includes(:prices),
      bedrooms: params[:bedrooms],
      not_sold: params[:not_sold]
    ).filter
  end

  def new
    @area = Area.new
  end

  def edit
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      redirect_to @area, notice: 'Area was successfully created.'
    else
      render :new
    end
  end

  def update
    if @area.update(area_params)
      redirect_to @area, notice: 'Area was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @area.destroy
      redirect_to areas_url, notice: 'Area was successfully destroyed.'
    else
      redirect_to areas_url, notice: 'Failed to destroy area'
    end
  end

  private
    def set_area
      @area = Area.find(params[:id])
    end

    def area_params
      params.require(:area).permit(:url, :name, :bedrooms)
    end
end
