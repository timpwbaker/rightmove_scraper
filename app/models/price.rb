class Price < ApplicationRecord
  belongs_to :listing

  def self.chronological
    all.sort_by(&:date)
  end

  def self.previous
    chronological.first(self.count - 1).reverse
  end

  def pretty_date
    date.strftime("%d %b %y")
  end
end
