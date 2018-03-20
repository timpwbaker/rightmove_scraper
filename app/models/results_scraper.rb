class ResultsScraper
  def initialize(url)
    browser.visit url
    pages = browser.all(:css, '.pagination-dropdown option').last.text.to_i
    (1..pages).each do |n|
      browser.find_all(:css, '.l-searchResult').each do |result|
        if result.find_all(:css, 'a.propertyCard-link').first
          Listing.find_or_create_by(rightmove_id: rightmove_id(result)) do |listing|
            listing.price = result.find(:css, '.propertyCard-priceValue').text.gsub(/£|,/, "").to_i
            listing.address = result.find(:css, 'address.propertyCard-address').text
            if result.find(:css, '.propertyCard-branchSummary-addedOrReduced').text.split(" ").first == "Added"
              listing.added_on = parsed_date(result.find(:css, '.propertyCard-branchSummary-addedOrReduced').text.split(" ").last)
            else
              listing.reduced_on = parsed_date(result.find(:css, '.propertyCard-branchSummary-addedOrReduced').text.split(" ").last)
            end
            listing.title = result.find(:css, 'h2.propertyCard-title').text
            listing.description =  result.find(:css, '.propertyCard-description').text
          end
        end
      end
      if n < pages
        browser.find(:css, '.pagination-dropdown').select (n + 1)
        browser.find(:css, '.pagination-button.pagination-direction.pagination-direction--next').click
      end
    end
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

  def driver
    @_driver ||= browser.driver.browser
  end
end
