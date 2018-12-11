class Interface
  CHOICES_MENU = {
    '1' => { label: 'Взять карту', action: :take },
    '2' => { label: 'Открыть карты', action: :open },
    '3' => { label: 'Пропустить ход', action: :skip },
  }.freeze
  GAME_MENU = {
    '1' => { label: 'Продолжить игру', action: :continue },
    '0' => { label: 'Взять банк и покинуть казино', action: :exit },
  }.freeze

  def initialize

  end

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
    puts "Раунд #{number}"
  end

  def show_winner(player)
    puts "Раунд выиграл #{player.name}"
  end

  def players_status
    puts "Играет #{game.player1.name} ($#{game.player1.bank}) против " \
         "#{game.player2.name} ($#{game.player2.bank})"
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
    puts '==================='
    menu.each { |k, v| puts "#{k} - #{v[:action]}" }
    puts '==================='
  end
end
