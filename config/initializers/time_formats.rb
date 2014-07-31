Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%_m/%e/%y") + " at " + time.strftime("%l:%M") + time.strftime("%p").downcase }
