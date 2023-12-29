defmodule Cards do

  # returns the list of cards
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # list comprehension -> returns a list
#    for suit <- suits do
#      suit
#    end

#    ["Spades", "Clubs", "Hearts", "Diamonds"]


    #    WRONG METHOD -> because we need single list
#    cards = for value <- values do
#      for suit <- suits do
#        "#{value} of #{suit}"
#      end
#    end
#
#    cards = [
#      ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds"],
#      ["Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds"],
#      ["Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds"],
#      ["Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds"],
#      ["Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]
#    ]

#   TODO: solution 01 ^ depends on the above code ^
#    List.flatten(cards)

#    ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
#      "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
#      "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
#      "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
#      "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]

#   TODO: solution 02
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

  end

  # added function guard to check if the argument is a list
  def shuffle(deck) when is_list(deck) do
     Enum.shuffle(deck)
  end

  # every other parameter type
  def shuffle(_) do
    :error
  end

  # returns true or false if a card exists or not in the deck
  def contains?(deck, card) when is_list(deck) and is_binary(card) do
    Enum.member?(deck, card)
  end

  # return specified no. of cards
  def deal(deck, hand_size) when is_list(deck) and is_integer(hand_size) do
    Enum.split(deck, hand_size) # returns a tuple of lists with 2 lists in a split -> {[],[]}
  end

end
