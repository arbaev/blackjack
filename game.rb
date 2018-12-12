class Game
  attr_reader :player1, :player2, :round_counter, :bet

  def initialize(pl1, pl2, io, bet)
    @bet = bet
    @round_counter = 0
    @io = io
    @player1 = pl1
    @player2 = pl2
    make_game
  end

  # запросить - игра комп-комп или человек-комп
  # DONE: запросить имя игрока
  # запросить ставку и банк
  # игровой цикл

  # объявить номер раунда
  # сделать ставки
  # сыграть раунд
  # объявить победителя раунда
  # обновить банки и показать их
  # объявить лузера, если таковой есть
  # спросить о продолжении
  def make_game
    loop do
      main
      what_next = io.menu(Interface::GAME_MENU)
      break if what_next == :exit

      reset_cards
    end
  end

  def main
    io.show_round(@round_counter += 1)
    bets_make
    round = Round.new(@player1, @player2, @io)
    winner = round.play_round
    if winner == :draw || winner == :both_lost
      puts 'ничья'
      bets_back
    else
      winner.bank += @bet * 2
      io.show_winner(winner)
    end
    io.players_status(@player1, @player2)
    ruined = [@player1, @player2].select { |pl| check_loser(pl) }.first
    if ruined
      # объявить лузера, если таковой есть и выйти
      puts "#{ruined.name} RUINED!"
      abort
    end
  end

  def bets_make
    @player1.bank -= @bet
    @player2.bank -= @bet
  end

  def bets_back
    @player1.bank += @bet
    @player2.bank += @bet
  end

  def check_loser(player)
    player.bank <= 0 ? player : false
  end

  def reset_cards
    @player1.cards.clear
    @player2.cards.clear
  end
end
