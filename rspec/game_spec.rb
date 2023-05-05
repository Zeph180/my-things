require_relative '../game'

describe Game do
  context 'When testing the Game class' do
    it 'The initialize method should return create new Game object' do
      game = Game.new(true, '2019-01-1')
      expect(game.multiplayer).to be true
    end

    it 'The move_to_archive? method should return true' do
      game = Game.new(true, '2019-01-1')
      expect(game.move_to_archive).to be true
    end
  end
end
