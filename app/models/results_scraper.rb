class ResultsScraper
  attr_reader :area

  def initialize(area)
    @area = area
  end

  def scrape
    browser.visit url
    pages = browser.all(:css, '.pagination-dropdown option').last.text.to_i
    (1..pages).each do |n|
      sleep(5)
      browser.find_all(:css, '.l-searchResult').each do |result|
        sleep(1)
        if result.find_all(:css, 'a.propertyCard-link').first
          listing = Listing.find_or_create_by(rightmove_id: rightmove_id(result))

          date = parsed_date(result.find(:css, '.propertyCard-branchSummary-addedOrReduced').text.split(" ").last)
          reduced = result.find(:css, '.propertyCard-branchSummary-addedOrReduced').text.split(" ").first != "Added"
          price = result.find(:css, '.propertyCard-priceValue').text.gsub(/£|,/, "").to_i
          address = result.find(:css, 'address.propertyCard-address').text
          title = result.find(:css, 'h2.propertyCard-title').text
          description = result.find(:css, '.propertyCard-description').text
          tags = result.find_all(:css, '.propertyCard-tagTitle').select{|x| x.visible?}.map(&:text)
          bedrooms = title.first.to_i

          listing.area = area
          listing.address = address
          if reduced
            listing.reduced_on = date
          else
            listing.added_on = date
          end
          listing.title = title
          listing.bedrooms = bedrooms
          listing.description = description
          listing.tags = tags

          listing.save
          if listing.prices.where(date: date, amount: price).none?
            listing.prices.create(date: date, reduction: reduced, amount: price)
          end
        end
      end
      while n < pages && browser.find(:css, '.pagination-dropdown').find_all(:css, 'option')[n] != browser.find(:css, '.pagination-dropdown').find_all(:css, 'option').select { |x| x.selected? }.first
        browser.find(:css, '.pagination-dropdown').select (n + 1)
        browser.find(:css, '.pagination-button.pagination-direction.pagination-direction--next').click
        sleep(1)
      end
    end
  end

  def url
    area.url
  end

  def parsed_date(date_string)
    if date_string == "today"
      Date.today
    elsif date_string == "yesterday"
      Date.yesterday
    else
      Date.parse(date_string)
    end
  end


  def rightmove_id(result)
    link = result.find_all(:css, 'a.propertyCard-link').first
    uri = URI.parse(link[:href])
    File.basename(
      uri.path,
      ".*"
    ).gsub(/property-/, "").to_i
  end

  def browser
    @_browser ||= Capybara.current_session
  end
end
