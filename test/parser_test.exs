defmodule Slab.ParserTest do
  use ExUnit.Case, async: false # TODO: Make Sync. Async for printing.

  alias Slab.ParserElement, as: E

  defmacro text ~> expected do
    quote bind_quoted: binding do
      assert Slab.Parser.parse!(text) == expected
    end
  end

  def print(slab) do
    IO.puts ""
    IO.inspect slab
    IO.inspect Slab.Parser.parse!(slab)
  end


  test "dev printing" do
    print """
    h3 f
    h3  f
    """
  end

  test "preceeding spaces" do
    """
    h1 o
    h2  o
    h3   o
    """ ~> [
      %E{labels: [], type: 'h1', text: 'o'  }, :nl,
      %E{labels: [], type: 'h2', text: ' o' }, :nl,
      %E{labels: [], type: 'h3', text: '  o'},
    ]
  end

  test "classes and ids" do
    """
    .hi Yo
    #there
    .c#i
    a.you
    b#today
    """ ~> [
      %E{labels: [class: 'hi'], text: 'Yo' }, :nl,
      %E{labels: [id: 'there']             }, :nl,
      %E{labels: [class: 'c', id: 'i']     }, :nl,
      %E{labels: [class: 'you'], type: 'a' }, :nl,
      %E{labels: [id: 'today'],  type: 'b' },
    ]
  end
end
