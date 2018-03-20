namespace :scrape_listings do
  desc "Scrape the listings for all the areas"
  task all_areas: :environment do
    Area.all.map(&:scrape)
  end
end
