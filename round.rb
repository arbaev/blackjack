# main cycle of game
class Round
  BLACKJACK = 21

  def initialize(player1, player2, bet)
    @player1 = player1
    @player2 = player2
    @bet = bet
    @deck = Deck.new
  end

  def play_round
    deal_2cards
    make_bet(@bet)
    show_scores
    [@player1, @player2].each { |p| move(p) }
    show_scores
    open_cards
  end

  private

  def move(player)
    puts "Ход #{player.name}, решение: #{player.decision}"
    player.take_card(@deck.deal_card) if player.decision == :take
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

  def deal_2cards
    @player1.take_card(@deck.deal_card)
    @player1.take_card(@deck.deal_card)
    @player2.take_card(@deck.deal_card)
    @player2.take_card(@deck.deal_card)
  end

  def make_bet(how_much)
    @player1.bank -= how_much
    @player2.bank -= how_much
  end

  def show_scores
    puts "#{@player1.name}: #{@player1.show_cards} [#{@player1.score}] | "\
         "#{@player2.name}: #{@player2.show_cards} [#{@player2.score}]"
  end
end