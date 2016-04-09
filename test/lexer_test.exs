defmodule Slab.LexerTest do
  use ExUnit.Case

  defmacro text ~> tokens do
    quote bind_quoted: binding do
      assert Slab.Lexer.tokenize(text) == tokens
    end
  end

  # .tokenize/1

  test "tags" do
    "h1" ~> [
      {:name, 1, 'h1'},
    ]
    "  h1" ~> [
      {:spaces, 1, 2},
      {:name,   1, 'h1'},
    ]
  end

  test "ids" do
    "#foo" ~> [
      {:prefix, 1, '#'},
      {:name,   1, 'foo'},
    ]
    "#xx#yy" ~> [
      {:prefix, 1, '#'},
      {:name,   1, 'xx'},
      {:prefix, 1, '#'},
      {:name,   1, 'yy'},
    ]
    "#who-what_slimSHADY" ~> [
      {:prefix, 1, '#'},
      {:name,   1, 'who-what_slimSHADY'},
    ]
  end

  test "class literal" do
    ".bar" ~> [
      {:prefix, 1, '.'},
      {:name,   1, 'bar'},
    ]
    ".x.y" ~> [
      {:prefix, 1, '.'},
      {:name,   1, 'x'},
      {:prefix, 1, '.'},
      {:name,   1, 'y'},
    ]
    ".WHAT-where__when" ~> [
      {:prefix, 1, '.'},
      {:name,   1, 'WHAT-where__when'},
    ]
  end

  test "tags with text content" do
    "div Hello, world!" ~> [
      {:name,   1, 'div'},
      {:spaces, 1, 1},
      {:word,   1, 'Hello,'},
      {:spaces, 1, 1},
      {:word,   1, 'world!'},
    ]
  end
end
