# frozen_string_literal: true

require_relative 'item'

class Label
  attr_accessor :title, :items, :id, :color

  def initialize(title, color)
    @id = rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items.push(item)
    item.label = self
  end
end
