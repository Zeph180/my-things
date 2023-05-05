class Book < Item
  attr_accessor :author, :publisher, :cover_state, :label

  def initialize(name, description, type, published_date, author, publisher, cover_state)
    super(name, description, type, published_date)
    @author = author
    @publisher = publisher
    @cover_state = cover_state
    @label = nil
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
