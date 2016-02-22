module Listable
  def format_description(description)
  	"#{description}".ljust(30)
  end

  def format_priority(priority)
  	value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end

  def format_date(type, options={})
  	type = type.downcase
  	formatted_date = ""

  	if type == "event"
  		start_date = options[:start_date]
  		end_date = options[:end_date]

  		if !start_date && !end_date
  			formatted_date = "N/A" 
  		else
  			formatted_date = @start_date.strftime("%D") if @start_date
    		formatted_date << " -- " + @end_date.strftime("%D") if @end_date
    	end
    end

	  if type == "todo"
	  	due = options[:due]
	  	formatted_date = due ? due.strftime("%D") : "No due date"
	  end

	  return formatted_date
  end
end
