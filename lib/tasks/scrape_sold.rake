namespace :scrape_sold do
  desc "Scrape the listings for sold prices"
  task all_listings: :environment do
    Listing.all.each do |l|
      puts "getting sold price for listing #{l.id}"
      begin
        SoldScraper.new(l).scrape
      rescue => error
        Rails.logger.debug error.inspect
      end
    end
  end
end

