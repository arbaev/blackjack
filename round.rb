require_relative 'interface'
# main cycle of game
class Round
  include Interface
  BLACKJACK = 21

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @deck = Deck.new
  end

  def play_round
    deal_cards(@player1, 2)
    deal_cards(@player2, 2)
    Interface.show_scores(@player1, @player2, :hidden)
    [@player1, @player2].each { |p| move(p) }
    Interface.show_scores(@player1, @player2)
    open_cards
  end

  private

  def move(player)
    decision = player.decision
    Interface.show_decision(player, decision)
    player.take_card(@deck.deal_card) if decision == :take
  end

  def open_cards
    # Выигрывает игрок, у которого сумма очков ближе к 21
    # Если у игрока сумма очков больше 21, то он проиграл
    # Если сумма очков у игрока и дилера одинаковая, то объявляется ничья
    return :both_lost if [@player1.score, @player2.score].min > BLACKJACK

    return @player1 if @player2.score > BLACKJACK
    return @player2 if @player1.score > BLACKJACK
    return @player1 if BLACKJACK - @player1.score < BLACKJACK - @player2.score
    return @player2 if BLACKJACK - @player1.score > BLACKJACK - @player2.score

    :draw
  end

  def deal_cards(player, quantity)
    quantity.times { player.take_card(@deck.deal_card) }
  end

  def make_bet(how_much)
    @player1.bank -= how_much
    @player2.bank -= how_much
  end
end
