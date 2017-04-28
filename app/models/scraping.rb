class Scraping
  def self.get_currency
    agent = Mechanize.new
    page = agent.get("http://ja.exchange-rates.org/MajorRates.aspx")

    currency = page.at('.text-nowra a').inner_text if page.at('.text-nowra a')

    currency = Currency.new(currency: currency)
    currency.save
  end
end
