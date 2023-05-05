class Label
  @@id = 0

  attr_accessor :name, :items, :id

  def initialize(name)
    @@id += 1
    @id = @@id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.label = self
  end
end
