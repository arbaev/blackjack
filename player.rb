require_relative 'interface'

class Player
  include Interface
  attr_accessor :bank
  attr_reader :name, :cards

  def initialize(name, bank)
    @name = name
    @bank = bank
    @cards = []
  end

  def take_card(card)
    @cards << card
  end

  def score
    # туз может равняться 1 или 11 очкам, на выбор игрока, поэтому
    # если есть туз и счёт менее или равен 11, то счёт += 10
    raw = score_raw
    raw += 10 if ace? && raw <= 11
    raw
  end

  def decision
    Interface.menu(Interface::CHOICES_MENU)
  end

  def show_cards
    @cards.reduce('') { |acc, card| acc + "#{card.show} " }.lstrip
  end

  def show_cards_hidden
    @cards.reduce('') { |acc, _card| acc + '** ' }.lstrip
  end

  def score_hidden
    'XX'
  end

  private

  def score_raw
    @cards.reduce(0) { |acc, card| acc + card.value }
  end

  def ace?
    !!@cards.detect { |card| card.rank == 1 }
  end
end
