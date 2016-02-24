class UdaciList
  attr_reader :title, :items
  @@item_types = ["todo", "event", "link", "reminder"]

  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    if  !@@item_types.index(type)
      raise UdaciListErrors::InvalidItemTypeError
    end

    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
    @items.push Reminder.new(description, options) if type == "reminder"
  end

  def delete(index)
    if @items.length < index
      raise UdaciListErrors::IndexExceedsListSizeError
    end

    @items.delete_at(index - 1)
  end

  def delete_multiple(indexes_list)
    counter = 0
    indexes_list.sort!.each { |item_index|
      delete(item_index - counter)
      counter = counter + 1
    }
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def filter(item_type)
    selected_items = @items.select { |item| Listable.get_item_type(item) == item_type}
    if selected_items.length == 0
      return "No items of type #{item_type} found"
    else
      return selected_items
    end
  end

end
