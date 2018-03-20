class Price < ApplicationRecord
  belongs_to :listing

  def self.chronological
    all.sort_by(&:date)
  end
end
