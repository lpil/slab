defmodule Slab.LexerTest do
  use ExUnit.Case

  defmacro text ~> tokens do
    quote bind_quoted: binding do
      assert Slab.Lexer.tokenize!(text) == tokens
    end
  end

  test "tags" do
    "h1" ~> [
      {:name, 1, 'h1'},
    ]
    "  h1" ~> [
      {:s,    1, '  ', 2},
      {:name, 1, 'h1'},
    ]
  end

  test "ids" do
    "#foo" ~> [
      {:"#",  1},
      {:name, 1, 'foo'},
    ]
    "#xx#yy" ~> [
      {:"#",  1},
      {:name, 1, 'xx'},
      {:"#",  1},
      {:name, 1, 'yy'},
    ]
    "#who-what_slimSHADY" ~> [
      {:"#",  1},
      {:name, 1, 'who-what_slimSHADY'},
    ]
  end

  test "class literal" do
    ".bar" ~> [
      {:.,    1},
      {:name, 1, 'bar'},
    ]
    ".x.y" ~> [
      {:.,    1},
      {:name, 1, 'x'},
      {:.,    1},
      {:name, 1, 'y'},
    ]
    ".WHAT-where__when" ~> [
      {:.,    1},
      {:name, 1, 'WHAT-where__when'},
    ]
  end

  test "tags with text content" do
    "div Hello, world!" ~> [
      {:name, 1, 'div'},
      {:s,    1, ' ', 1},
      {:word, 1, 'Hello,'},
      {:s,    1, ' ', 1},
      {:word, 1, 'world!'},
    ]
    "div I'm spartacus" ~> [
      {:name, 1, 'div'},
      {:s,    1, ' ', 1},
      {:word, 1, 'I\'m'},
      {:s,    1, ' ', 1},
      {:name, 1, 'spartacus'},
    ]
  end

  test "newlines" do
    """
    div
      h1 Hi!
    """ ~> [
      {:name, 1, 'div'},
      {:nl,   1},
      {:s,    2, '  ', 2},
      {:name, 2, 'h1'},
      {:s,    2, ' ',  1},
      {:word, 2, 'Hi!'},
      {:nl,   2},
    ]
  end

  test "other whitespace is ignored" do
    "\tdiv" ~> [
      {:name, 1, 'div'},
    ]
  end
end
