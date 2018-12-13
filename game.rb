require_relative 'interface'
# main cycle of game
class Game
  include Interface
  attr_reader :player1, :player2, :bet

  def initialize(bank = 100, bet = 10)
    Interface.welcome_message
    @bank_start = bank
    @bet = bet
    @round_counter = 0
    @player1 = Player.new(Interface.name, bank)
    @player2 = Dealer.new('Dealer', bank)
    make_game
  end

  def make_game
    loop do
      main
      what_next = menu(Interface::GAME_MENU)
      break if what_next == :exit

      reset_cards
    end
    show_final(player1, @bank_start)
  end

  def main
    Interface.show_round_welcome(@round_counter += 1)
    Interface.show_round_status(player1, player2, bet)
    bets_make
    round = Round.new(player1, player2)
    round.play
    winner = round.winner
    check_winner(winner)
    show_players_status(player1, player2)
    check_ruined
  end

  def bets_make
    player1.place_bet(@bet)
    player2.place_bet(@bet)
  end

  def bets_back
    player1.topup_bank(@bet)
    player2.topup_bank(@bet)
  end

  def reset_cards
    player1.hand.reset
    player2.hand.reset
  end

  def check_loser(player)
    player.bank <= 0 ? player : false
  end

  def check_winner(winner)
    if winner == :draw || winner == :both_lost
      Interface.show_draw
      bets_back
    else
      winner.topup_bank(bet * 2)
      Interface.show_winner(winner)
    end
  end

  def check_ruined
    ruined = [player1, player2].select { |pl| check_loser(pl) }.first
    if ruined
      Interface.show_ruined(ruined)
      abort
    end
  end
end
