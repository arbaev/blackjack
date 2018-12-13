module Interface
  CHOICES_MENU = {
    '1' => { label: 'Взять карту', action: :take },
    '2' => { label: 'Открыть карты', action: :open },
    '3' => { label: 'Пропустить ход', action: :skip }
  }.freeze
  GAME_MENU = {
    '1' => { label: 'Продолжить игру', action: :continue },
    '0' => { label: 'Взять банк и покинуть казино', action: :exit }
  }.freeze

  module_function

  def name
    ask('Как вас зовут?')
  end

  def menu(menu)
    showmenu(menu)
    while choice = menu[ask('?>').to_s] || {}

      break choice[:action] unless choice[:action].nil?

      unknown_command
    end
  end

  def show_round_welcome(number)
    puts '==================='
    puts "===== Раунд #{number} ====="
  end

  def show_winner(player)
    puts "=> Раунд выиграл #{player.name}"
  end

  def show_round_status(player1, player2, bet)
    puts "Играет #{player1.name} ($#{player1.bank}) против " \
         "#{player2.name} ($#{player2.bank}). Ставка $#{bet}"
  end

  def show_players_status(player1, player2)
    puts "Итог раунда: #{player1.name} ($#{player1.bank}) | " \
         "#{player2.name} ($#{player2.bank})."
  end

  def show_decision(player, decision)
    puts "Ход #{player.name}, решение: #{decision}"
  end

  def show_scores(player1, player2, type = :open)
    type == :open ? show_scores_open(player1, player2) : show_scores_hidden(player1, player2)
  end

  def show_scores_open(player1, player2)
    puts "#{player1.name}: #{player1.hand.show} [#{player1.hand.score}] | "\
    "#{player2.name}: #{player2.hand.show} [#{player2.hand.score}]"
  end

  def show_scores_hidden(player1, player2)
    puts "#{player1.name}: #{player1.hand.show} [#{player1.hand.score}] | "\
    "#{player2.name}: #{player2.hand.show_hidden} [#{player2.hand.score_hidden}]"
  end

  def welcome_message
    puts '--- Добро пожаловать ---'
    puts '--- в игру Blackjack ---'
  end

  def show_ruined(player)
    puts '--- Игра окончена ---'
    puts "=> Игрок #{player.name} весь проигрался"
  end

  def show_draw
    puts '=> Ничья, ставки возвращены'
  end

  def show_final(player, start_bank)
    if player.bank < start_bank
      puts "=> Всего доброго, #{player.name}! Ваш проигрыш составил $#{start_bank - player.bank}"
    else
      puts "=> Всего доброго, #{player.name}! Ваш выигрыш составил $#{player.bank - start_bank}"
    end
  end

  def ask(question)
    print question + ' '
    gets.chomp
  end

  def unknown_command
    puts '=> unknown command'
  end

  def showmenu(menu)
    puts '-------------------'
    menu.each { |k, v| puts "#{k} - #{v[:label]}" }
    puts '-------------------'
  end
end
