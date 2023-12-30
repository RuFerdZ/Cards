defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  # returns the list of cards
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
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
  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
      "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
      "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
      "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) when is_list(deck) and is_binary(card) do
    Enum.member?(deck, card)
  end

  # return specified no. of cards
  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) when is_list(deck) and is_integer(hand_size) do
    Enum.split(deck, hand_size) # returns a tuple of lists with 2 lists in a split -> {[],[]}
  end

  # save the deck to a file
  def save(deck, filename) when is_list(deck) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  # load the data from a file
  def load(filename) do
#    {status, binary} = File.read(filename)
#
#    # check if the file is loaded properly
#    case status do
#      :ok -> :erlang.binary_to_term(binary)
#      :error -> "The file does not exist!"
#    end

    # above using pattern matching
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "The file does not exist!"  # we use _ since we wont use that variable and wont produce unused variable warning
    end
  end

  # automating create_deck -> shuffle -> deal
  @doc """
    Pipe Operator |>
    It passes the result of each method as the first argument of the next function
  """
  def create_hand(hand_size) do
    # without piping
#    deck = Cards.create_deck
#    deck = Cards.shuffle(deck)
#    hand = Cards.deal(deck, hand_size)

    # with piping
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
