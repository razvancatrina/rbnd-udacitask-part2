class Reminder
	include Listable
	attr_reader :title, :remind_on

	def initialize(title, options={})
		@title = title
		@remind_on = options[:remind_on]
	end

	def details
		format_description(@title) + " remind on " + Date.parse(@remind_on).strftime("%D")
	end
end