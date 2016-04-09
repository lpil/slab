defmodule Slab.ParserTest do
  use ExUnit.Case, async: false # For printing

  defmacro text ~> tree do
    quote bind_quoted: binding do
      assert Slab.Parser.parse!(text) == tokens
    end
  end

  def print(slab) do
    IO.puts ""
    IO.inspect slab
    IO.inspect Slab.Parser.parse!(slab)
  end


  test "classes" do
    print """
    h1#who.what
    div
    #main
    """
  end
end
