class Item
  attr_accessor :name, :description, :type, :published_date, :archived, :tags, :images

  def initialize(name, description, type, published_date)
    @name = name
    @description = description
    @type = type
    @published_date = published_date
    @archived = false
  end

  def can_be_archived?
    (Time.now.year - @published_date.year) > 10
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
    end
  end
end
