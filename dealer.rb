class Dealer < Player
  def decision
    # Пропустить ход (если очков 17 или более)
    # Добавить карту (если очков менее 17)
    return :open if hand.cards.size == 3

    return :take if hand.score < 17

    :skip
  end
end
