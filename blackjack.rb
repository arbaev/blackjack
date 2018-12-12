require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'
require_relative 'round'
require_relative 'game'
require_relative 'interface'

class Blackjack
  include Interface

  def initialize(bank = 100, bet = 10)
    @bank = bank
    @bet = bet
    # @player1 = Player.new(@io.name, bank)
    @player1 = Player.new('tim', bank)
    @player2 = Dealer.new('Dealer', bank)
    Game.new(@player1, @player2, @bet)
  end
end
