class Price < ApplicationRecord
  belongs_to :listing

  def self.chronological
    all.sort_by(&:date)
  end

  def self.previous
    self.last self.all.count - 1
  end
end
