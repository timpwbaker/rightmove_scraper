class Area < ApplicationRecord
  has_many :listings, dependent: :destroy

  def scrape
    ResultsScraper.new(self).scrape
  end
end
