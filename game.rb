class Game
  attr_accessor :io
  attr_reader :player1, :player2, :round_counter

  def initialize(bank = 100, bet = 10)
    @bank = bank
    @bet = bet
    @round_counter = 0
    @io = Interface.new
    @player1 = Player.new(io.name, bank)
    @player2 = Dealer.new('Dealer', bank)
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
    while result = main
      what_next = io.menu(io.GAME_MENU)
      break result unless what_next == :exit

    end
  end

  def main
    io.show_round(@round_counter += 1)
    make_bets
    round = Round.new(@player1, @player2)
    winner = round.play_round
    if winner == :draw || winner == :both_lost
      puts 'ничья'
      bet_back
    else
      winner.bank += @bet * 2
      io.show_winner(winner)
    end
    io.players_status
    ruined = [@player1, @player2].each(&:check_loser)
    if ruined
      # объявить лузера, если таковой есть и выйти
      puts "#{ruined.name} RUINED!"
    end
  end

  def make_bets
    @player1.bank -= @bet
    @player2.bank -= @bet
  end

  def check_loser(player)
    player.bank <= 0 ? player : false
  end
end
