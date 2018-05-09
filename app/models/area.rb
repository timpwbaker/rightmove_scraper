class Area < ApplicationRecord
  has_many :listings, dependent: :destroy

  def scrape
    ResultsScraper.new(self).scrape
  end

  def agents_hash
    agents = self.listings.map(&:agent)
    hash = Hash.new 0

    agents.each do |agent|
      hash[agent] += 1
    end

    hash
  end
end
