require 'json'
require 'date'
require_relative 'item'
require_relative 'book'
require_relative 'label'
require_relative 'author'
require_relative 'game'

class App
  attr_accessor :books, :games, :authors, :labels, :music_albums, :genres

  def initialize
    # @music_albums = read_music_albums
    # @genres = read_genres
    @books = []
    @labels = []
    @games = []
    @authors = []
  end

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

  def list_games(games)
    if games.empty?
      puts 'No games found.'
    else
      puts 'Games:'
      games.each do |game|
        puts "Multiplayer: #{game.multiplayer}, Last Played At: #{game.last_played_at}"
      end
    end
  end

  def list_authors(authors)
    if authors.empty?
      puts 'No authors found.'
    else
      puts 'Authors:'
      authors.each do |author|
        puts "Publish date : #{item.publish_date}"
        puts "#{author.first_name} #{author.last_name}"
        puts ''
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

  def add_game
    puts 'Enter game details:'
    print 'Multiplayer?: '
    multiplayer = gets.chomp
    print 'Last Played At: '
    last_played_at = gets.chomp

    games.push(Game.new(multiplayer, last_played_at))
    puts 'Game created successfully.'
  end

  def menu
    items, labels = load_data

    loop do
      puts 'Please choose an option:'
      puts '1. List all books'
      puts '2. List all labels'
      puts '3. List all games'
      puts '4. List all authors'
      puts '5. Add a book'
      puts '6. Add a label'
      puts '7. Add a game'
      puts '8. Quit'
      choice = gets.chomp.to_i

      case choice
      when 1
        list_books(items.select { |item| item.is_a?(Book) })
      when 2
        list_labels(labels)
      when 3
        list_games(games)
      when 4
        list_authors(authors)
      when 5
        add_book(labels)
      when 6
        add_label(labels)
      when 7
        add_game
      when 8
        puts 'Goodbye!'
        break
      else
        puts 'Invalid option. Please try again.'
      end
    end
  end
end
