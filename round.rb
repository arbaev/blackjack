require_relative 'interface'
# main cycle of game
class Round
  include Interface
  BLACKJACK = 21
  attr_reader :winner

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @winner = nil
    @deck = Deck.new
  end

  def play
    deal_cards(@player1, 2)
    deal_cards(@player2, 2)
    Interface.show_scores(@player1, @player2, :hidden)
    [@player1, @player2].each { |p| move(p) }
    @winner = who_wins
    Interface.show_scores(@player1, @player2)
  end

  private

  def move(player)
    decision = player.decision
    Interface.show_decision(player, decision)
    player.hand.take_card(@deck.deal_card) if decision == :take
  end

  def who_wins
    # Выигрывает игрок, у которого сумма очков ближе к 21
    # Если у игрока сумма очков больше 21, то он проиграл
    # Если сумма очков у игрока и дилера одинаковая, то объявляется ничья
    score1 = @player1.hand.score
    score2 = @player2.hand.score
    return :both_lost if [score1, score2].min > BLACKJACK

    return @player1 if score2 > BLACKJACK
    return @player2 if score1 > BLACKJACK
    return @player1 if BLACKJACK - score1 < BLACKJACK - score2
    return @player2 if BLACKJACK - score1 > BLACKJACK - score2

    :draw
  end

  def deal_cards(player, quantity)
    quantity.times { player.hand.take_card(@deck.deal_card) }
  end
end
