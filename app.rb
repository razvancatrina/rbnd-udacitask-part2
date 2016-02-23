require 'bundler/setup'
require 'chronic'
require 'colorize'
# Find a third gem of your choice and add it to your project
require 'terminal-table'
require 'date'
require_relative "lib/listable"
require_relative "lib/errors"
require_relative "lib/udacilist"
require_relative "lib/todo"
require_relative "lib/event"
require_relative "lib/link"

list = UdaciList.new(title: "Julia's Stuff")
list.add("todo", "Buy more cat food", due: "2016-02-03", priority: "low")
list.add("todo", "Sweep floors", due: "2016-01-30")
list.add("todo", "Buy groceries", priority: "high")
list.add("event", "Birthday Party", start_date: "2016-05-08")
list.add("event", "Vacation", start_date: "2016-05-28", end_date: "2016-05-31")
list.add("link", "https://github.com", site_name: "GitHub Homepage")
list.all
list.delete(3)
list.all

# SHOULD CREATE AN UNTITLED LIST AND ADD ITEMS TO IT
# --------------------------------------------------
new_list = UdaciList.new(title: "Untitled List") # Should create a list called "Untitled List"
new_list.add("todo", "Buy more dog food", due: Chronic.parse("in 5 weeks").to_s, priority: "medium")
new_list.add("todo", "Go dancing", due: Chronic.parse("in 2 hours").to_s)
new_list.add("todo", "Buy groceries", priority: "high")
new_list.add("event", "Birthday Party", start_date: Chronic.parse("May 31").to_s)
new_list.add("event", "Vacation", start_date: Chronic.parse("Dec 20").to_s, end_date: Chronic.parse("Dec 30").to_s)
new_list.add("event", "Life happens")
new_list.add("link", "https://www.udacity.com/", site_name: "Udacity Homepage")
new_list.add("link", "http://ruby-doc.org")

# SHOULD RETURN ERROR MESSAGES
# ----------------------------
# new_list.add("image", "http://ruby-doc.org") # Throws InvalidItemType error
# new_list.delete(9) # Throws an IndexExceedsListSize error
# new_list.add("todo", "Hack some portals", priority: "super high") # throws an InvalidPriorityValue error

# DISPLAY UNTITLED LIST
# ---------------------
new_list.all

# DEMO FILTER BY ITEM TYPE
# ------------------------
table = Terminal::Table.new
new_list.filter("event").each_with_index { |val, index|
	table << [index + 1,  val.details]
}

puts table

puts new_list.filter("non_existent_item")
