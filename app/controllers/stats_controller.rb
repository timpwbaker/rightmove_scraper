class StatsController < ApplicationController

  def index
    @listing_counts =
      area.listings.group_by { |m| m.created_at.beginning_of_month }.sort
  end

  private

  def area
    Area.find(params[:area_id])
  end
end
