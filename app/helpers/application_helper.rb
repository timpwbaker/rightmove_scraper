module ApplicationHelper
  def pretty_date(date)
    begin
      date.strftime("%d %b %y")
    rescue
      "unknown"
    end
  end
end
