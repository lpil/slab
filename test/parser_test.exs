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


  test "class" do
    print ".foo"
  end

  test "id" do
    print "#foo"
  end

  test "ids" do
    print "#foo#bar"
  end

  test "classes" do
    print ".foo.bar"
  end
end
