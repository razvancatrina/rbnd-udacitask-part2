module Listable
	@@priorities = ["high", "medium", "low"]

  def format_description(description)
  	"#{description}" + "(#{Listable.get_item_type(self)})".ljust(30) 
  end

  def self.get_item_type(item)
  	item.class.name.downcase.gsub('item', '')
  end

  def format_priority(priority)
		if  priority && !@@priorities.index(priority)
      raise UdaciListErrors::InvalidPriorityValueError
    end

  	value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:green) if priority == "medium"
    value = " ⇩".colorize(:yellow) if priority == "low"
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
