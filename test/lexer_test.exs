defmodule Slab.LexerTest do
  use ExUnit.Case

  defmacro slime ~> tokens do
    quote bind_quoted: binding do
      assert Slab.Lexer.tokenize(slime) == tokens
    end
  end

  # .tokenize/1

  test "tags" do
    "h1" ~> [
      {:indent, 0, 0},
      {:tag, 0, 'h1'},
    ]
    "  h1" ~> [
      {:indent, 0, 2},
      {:tag, 0, 'h1'},
    ]
  end

  test "ids" do
    "#foo" ~> [
      {:indent, 0, 0},
      {:id, 0, 'foo'},
    ]
    "#xx#yy" ~> [
      {:indent, 0, 0},
      {:id, 0, 'xx'},
      {:id, 0, 'yy'},
    ]
    "#who-what_slimSHADY" ~> [
      {:indent, 0, 0},
      {:id, 0, 'who-what_slimSHADY'},
    ]
  end

  test "class literal" do
    ".bar" ~> [
      {:indent, 0, 0},
      {:class, 0, 'bar'},
    ]
    ".x.y" ~> [
      {:indent, 0, 0},
      {:class, 0, 'x'},
      {:class, 0, 'y'},
    ]
    ".WHAT-where__when" ~> [
      {:indent, 0, 0},
      {:class, 0, 'WHAT-where__when'},
    ]
  end

  @tag :skip
  test "tags with text content" do
    "div Hello, world!" ~> [
      {:indent, 0, 0},
      {:tag, 0, 'div'},
      # something here.
    ]
  end
end
