class StatsController < ApplicationController

  def index
    @counts = counts
    @known_delisted_counts = known_delisted_counts
    @unknown_delisted_counts = unknown_delisted_counts
    @under_offer_counts = under_offer_counts
  end

  private

  def area
    @_area ||= Area.find(params[:area_id])
  end

  def listings
    @_listings ||= area.listings
  end

  def counts
    listings.group_by { |m| m.created_at.beginning_of_month }.sort
  end

  def known_delisted_counts
    listings.known_delisted
      .group_by { |m| m.time_delisted.beginning_of_month }.sort
  end

  def unknown_delisted_counts
    listings.unknown_delisted
  end

  def under_offer_counts
    listings.under_offer.group_by { |m| m.under_offer.beginning_of_month }.sort
  end
end
