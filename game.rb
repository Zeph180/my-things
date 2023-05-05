require_relative 'item'
class Game < Item
  attr_accessor :multiplayer, :last_played_at
  attr_reader :published_date

  def initialize(multiplayer, last_played_at, published_date)
    super(published_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?(item)
    super || Date.today > Date.iso8601(@last_played_at).next_year(2)
  end
end
