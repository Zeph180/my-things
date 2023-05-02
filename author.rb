class Author
    attr_accessor :first_name, :last_name,
    attr_reader :id, :items

    def initialize(first_name, last_name, items)
        @id = Random.rand(1..1000)
        @first_name = first_name
        @last_name = last_name
        @items = []
      end

    def add_item(item)
        @items.push(item)
        item.author = self
    end
end