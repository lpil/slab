defmodule Slab.LexerTest do
  use ExUnit.Case

  defmacro slime ~> tokens do
    quote bind_quoted: binding do
      assert Slab.Lexer.tokenize(slime) == tokens
    end
  end

  # .tokenize/1

  test "handles indents" do
    "  "   ~> [indent: 2]
    "    " ~> [indent: 4]
    "  b"  ~> [indent: 2, word: 'b']
  end

  test "tags" do
    "  b Hi" ~> [indent: 2, word: 'b', word: 'Hi']
  end
end
