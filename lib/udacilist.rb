class UdaciList
  attr_reader :title, :items
  @@item_types = ["todo", "event", "link"]

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
  end

  def delete(index)
    if @items.length-1 <= index
      raise UdaciListErrors::IndexExceedsListSizeError
    end

    @items.delete_at(index - 1)
  end

  def all
    puts Rainbow("-").green * @title.length
    puts Rainbow(@title).green 
    puts Rainbow("-").green * @title.length
    @items.each_with_index do |item, position|
      puts "#{Rainbow(position + 1).green}) #{Rainbow(item.details).cyan}"
    end
  end

  def filter(item_type)
    @items.select { |item| Listable.get_item_type(item) == item_type}
  end

end
