defmodule SpellChecker do
  require Logger

  @moduledoc """
  The `SpellChecker` module is designed to check the correctness of words against a predefined word list and provide suggestions for incorrect words.

  ## Functions
  `is_correct?/2`
  `is_correct/1`
  `is_correct!/2`
  """
  @file_path "lib\\wordlist.txt"

  def is_correct?(word_list, acc \\ [])

  def is_correct?([], acc) do
    acc
  end

  @doc """
  `is_correct?/2`
    This function checks if a list of words are correct and returns a list of the correct words.

    Parameters:

    `word_list` (list): A list of words to check.
    `acc` (list, optional): An accumulator for correct words (used internally, defaults to an empty list).

    Returns: A list of correct words.

  ## Examples

      iex> words = ["hello", "worlld", "Programming"]
      iex> SpellChecker.is_correct?(words)
      ["Programming", "hello"]

  """
  def is_correct?([new_word | rest], acc) do
    case MapSet.member?(load_word_list(), String.downcase(new_word)) do
      true ->
        is_correct?(rest, [new_word | acc])

      _ ->
        is_correct?(rest, acc)
    end
  end

  @doc """
    `is_correct/1`
    This function checks if a single word is correct.

    Parameters:

    word (string): A word to check.

    Returns: A tuple indicating if the word is correct.


  ## Examples

      iex> SpellChecker.is_correct("hello")
      {:ok, true}
      iex> SpellChecker.is_correct("worlld")
      {:none, false}

  """
  def is_correct(word) when is_bitstring(word) and word != "" do
    case MapSet.member?(load_word_list(), word) do
      true ->
        {:ok, true}

      false ->
        {:none, false}
    end
  end

  @doc """
    `is_correct!/2`
  This function checks if a single word is correct and provides suggestions if it is not.

  Parameters:

  `word` (string): A word to check.
  `suggest` (integer, optional): The number of suggestions to return (defaults to 5).


  ## Examples

      iex> SpellChecker.is_correct!("hello")
      {:ok, true}
      iex> SpellChecker.is_correct!("worlld", 5)
      ["unworldly", "worldling", "word", "world", "worldly"]

  """
  def is_correct!(word, suggest \\ 5) when is_bitstring(word) and word != "" do
    case MapSet.member?(load_word_list(), word) do
      true ->
        {:ok, true}

      false ->
        suggest(word, suggest)
    end
  end

  defp suggest(word, suggest) do
    Enum.reduce_while(load_word_list() |> Enum.to_list(), [], fn e, acc ->
      case String.jaro_distance(e, word)  do
        value when value > 0.83 and length(acc) <= suggest ->
        {:cont, [e | acc]}
        value when value < 2 and length(acc) === suggest ->
       {:halt, acc}
       _ ->
       {:cont, acc}
      end
    end)
  end

  defp load_word_list() do
    File.stream!(@file_path)
    |> Stream.map(&String.trim/1)
    |> Enum.into(MapSet.new())
  end
end
