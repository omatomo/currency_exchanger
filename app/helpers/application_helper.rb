module ApplicationHelper
	def full_title(page_title = "")
		base_title = "CurrencyEmergency"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
	  end
	end

	def date_format(datetime)
	    distance_of_time_in_words_to_now(datetime) + '前'
	end
end
