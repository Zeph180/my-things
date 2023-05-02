# require_relative 'item'
# require 'date'

# def print_menu
#   puts "Please choose an option:"
#   puts "1. Add new item"
#   puts "2. Edit item"
#   puts "3. Remove item"
#   puts "4. Archive item"
#   puts "5. View all items"
#   puts "6. Quit"
# end

# def add_item
#   puts "Enter name:"
#   name = gets.chomp
#   puts "Enter description:"
#   description = gets.chomp
#   puts "Enter type:"
#   type = gets.chomp
#   puts "Enter published date (yyyy-mm-dd):"
#   published_date = Date.parse(gets.chomp)

#   item = Item.new(name, description, type, published_date)
#   puts "Item added: #{item.name}"
# end

# def edit_item
#   puts "Enter name of item to edit:"
#   name = gets.chomp

#   # find item by name
#   # edit item properties
# end

# def remove_item
#   puts "Enter name of item to remove:"
#   name = gets.chomp

#   # find item by name
#   # remove item from list
# end

# def archive_item
#   puts "Enter name of item to archive:"
#   name = gets.chomp

#   # find item by name
#   # call move_to_archive method
# end

# def view_all_items
#   # print list of all items
# end

# # main program loop
# loop do
#   print_menu
#   choice = gets.chomp.to_i

#   case choice
#   when 1
#     add_item
#   when 2
#     edit_item
#   when 3
#     remove_item
#   when 4
#     archive_item
#   when 5
#     view_all_items
#   when 6
#     break
#   else
#     puts "Invalid choice. Please try again."
#   end
# end

require 'json'
require 'date'
require_relative 'item'
require_relative 'book'
require_relative 'label'

def load_data
  items_data = JSON.parse(File.read('items.json'), symbolize_names: true)
  items = []
  items_data.each do |item_data|
    case item_data[:type]
    when 'book'
      items << Book.new(item_data)
    end
  end

  labels_data = JSON.parse(File.read('labels.json'), symbolize_names: true)
  labels = []
  labels_data.each do |label_data|
    labels << Label.new(label_data)
  end

  items.each do |item|
    item_label_data = labels_data.find { |label_data| label_data[:id] == item.label_id }
    item.label = labels.find { |label| label.id == item_label_data[:id] }
    item.label.add_item(item)
  end

  [items, labels]
end

def save_data(items, labels)
  items_data = items.map(&:to_data)
  labels_data = labels.map(&:to_data)
  File.write('items.json', JSON.generate(items_data))
  File.write('labels.json', JSON.generate(labels_data))
end

def list_books(books)
  if books.empty?
    puts 'No books found.'
  else
    puts 'Books:'
    books.each do |book|
      puts "- #{book.title}, by #{book.author} (#{book.published_date})"
    end
  end
end

def list_labels(labels)
  if labels.empty?
    puts 'No labels found.'
  else
    puts 'Labels:'
    labels.each do |label|
      puts "- #{label.name} (#{label.items.length} items)"
    end
  end
end

def add_book(labels)
  puts 'Enter book details:'
  print 'Title: '
  title = gets.chomp
  print 'Author: '
  author = gets.chomp
  print 'Description: '
  description = gets.chomp
  print 'Published date (yyyy-mm-dd): '
  published_date = Date.parse(gets.chomp)

  book = Book.new(title, description, 'book', published_date, author, '', 'good')
  list_labels(labels)
  print 'Choose a label ID: '
  label_id = gets.chomp.to_i
  label = labels.find { |l| l.id == label_id }
  if label.nil?
    puts 'Label not found.'
  else
    label.add_item(book)
    puts 'Book added successfully.'
  end
end

def add_label(labels)
  puts 'Enter label details:'
  print 'Name: '
  name = gets.chomp
  print 'Color: '
  color = gets.chomp

  label = Label.new(name: name, color: color)
  labels << label

  puts 'Label added successfully.'
end


def main
  items, labels = load_data

  loop do
    puts 'Please choose an option:'
    puts '1. List all books'
    puts '2. List all labels'
    puts '3. Add a book'
    puts '4. Add a label'
    puts '5. Quit'
    choice = gets.chomp.to_i

    case choice
    when 1
      list_books(items.select { |item| item.is_a?(Book) })
    when 2
      list_labels(labels)
    when 3
      add_book(labels)
    when 4
      add_label(labels)
    when 5
      puts 'Goodbye!'
      break
    else
      puts 'Invalid option. Please try again.'
    end
  end
end

main
