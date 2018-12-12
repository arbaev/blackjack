module Interface
  CHOICES_MENU = {
    '1' => { label: 'Взять карту', action: :take },
    '2' => { label: 'Открыть карты', action: :open },
    '3' => { label: 'Пропустить ход', action: :skip },
  }.freeze
  GAME_MENU = {
    '1' => { label: 'Продолжить игру', action: :continue },
    '0' => { label: 'Взять банк и покинуть казино', action: :exit },
  }.freeze

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

  def show_round(number)
    puts '==================='
    puts "===== Раунд #{number} ====="
  end

  def show_winner(player)
    puts "=> Раунд выиграл #{player.name}"
  end

  def players_status(player1, player2)
    puts "Играет #{player1.name} ($#{player1.bank}) против " \
         "#{player2.name} ($#{player2.bank})"
  end

  def show_scores(player1, player2, type = :open)
    type == :open ? show_scores_open(player1, player2) : show_scores_hidden(player1, player2)
  end

  def show_scores_open(player1, player2)
    puts "#{player1.name}: #{player1.show_cards} [#{player1.score}] | "\
    "#{player2.name}: #{player2.show_cards} [#{player2.score}]"
  end

  def show_scores_hidden(player1, player2)
    puts "#{player1.name}: #{player1.show_cards} [#{player1.score}] | "\
    "#{player2.name}: #{player2.show_cards_hidden} [#{player2.score_hidden}]"
  end

  private

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
