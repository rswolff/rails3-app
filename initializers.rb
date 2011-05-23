#initializers
puts "Add custom date formaters."
date_time_formats = <<-DATE_TIME_FORMATS
Date::DATE_FORMATS.merge!(
  :short => "%Y/%m/%d",
  :med => "%d-%b-%Y",
  :long => "%A %B %d, %Y",
  :military => "%H%M"  
)

Time::DATE_FORMATS.merge!(
  :med => "%d-%b-%Y",
  :military => "%H%M",
  :short => "%I:%M %p"  
)
DATE_TIME_FORMATS

initializer "custom_date_formats.rb", date_time_formats