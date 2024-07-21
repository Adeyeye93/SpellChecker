defmodule SpellCheckerTest do
  use ExUnit.Case
  doctest SpellChecker

  test "Read the words" do
    assert SpellChecker.is_correct!("wrong")
  end
end
