require_relative 'interface'
# main cycle of game
class Round
  include Interface
  BLACKJACK = 21
  attr_reader :result

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @result = nil
    @deck = Deck.new
  end

  def play
    deal_cards(@player1, 2)
    deal_cards(@player2, 2)
    show_player_cards(@player1, :open)
    show_player_cards(@player2, :hidden)
    [@player1, @player2].each { |p| move(p) }
    @result = who_wins
    show_player_cards(@player1)
    show_player_cards(@player2)
  end

  private

  def move(player)
    decision = player.decision
    Interface.show_decision(player.name, decision)
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

  def show_player_cards(player, type = :open)
    if type == :open
      Interface.show_cards(player.name, player.hand.show, player.hand.score)
    else
      Interface.show_cards(player.name, player.hand.show_hidden, player.hand.score_hidden)
    end
  end
end
