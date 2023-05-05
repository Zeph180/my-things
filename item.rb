class Item
  attr_accessor :name, :description, :type, :published_date, :archived, :tags, :images, :author

  def initialize(name, description, type, published_date)
    @name = name
    @description = description
    @type = type
    @published_date = published_date
    @archived = false
  end

  def add_author(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end

  def can_be_archived?
    (Time.now.year - @published_date.year) > 10
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end
end
