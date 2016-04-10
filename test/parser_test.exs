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


  test "attributes" do
    """
    div who="shady"
    div f="ada" l="lovelace"
    """ ~> [
      %E{ attributes: [{'who', 'shady'}] }, :nl,
      %E{ attributes: [{'f', 'ada'}, {'l', 'lovelace'}] }, :nl,
    ]
  end

  test "attributes with text" do
    ~s(div who="shady" !! What now?) ~> [
      %E{ attributes: [{'who', 'shady'}], text: '!! What now?' },
    ]
  end

  test "preceeding spaces" do
    """
    h1 o
    h2  o
    h3   o
    """ ~> [
      %E{labels: [], type: 'h1', text: 'o'  }, :nl,
      %E{labels: [], type: 'h2', text: ' o' }, :nl,
      %E{labels: [], type: 'h3', text: '  o'}, :nl,
    ]
  end

  test "classes and ids" do
    """
    #there
    .hi Yo
    a.you
    b#today
    .c#i
    """ ~> [
      %E{labels: [id: 'there']              }, :nl,
      %E{labels: [class: 'hi'],  text: 'Yo' }, :nl,
      %E{labels: [class: 'you'], type: 'a'  }, :nl,
      %E{labels: [id: 'today'],  type: 'b'  }, :nl,
      %E{labels: [class: 'c', id: 'i']      }, :nl,
    ]
  end

  test "indentation" do
    """
    yes
      no
        maybe
      I
    dont
          know
    """ ~> [
      %E{indent: 0, type: 'yes'   }, :nl,
      %E{indent: 2, type: 'no'    }, :nl,
      %E{indent: 4, type: 'maybe' }, :nl,
      %E{indent: 2, type: 'I'     }, :nl,
      %E{indent: 0, type: 'dont'  }, :nl,
      %E{indent: 6, type: 'know'  }, :nl,
    ]
  end

  test "text with double quotes" do
    text = 'They said "what?". With quotes. "". Like this -> "'
    "h1 #{text}" ~> [
      %E{indent: 0, type: 'h1', text: text },
    ]
  end

  test "text with =" do
    text = ' == !=== =:= Huh?'
    "h1 #{text}" ~> [
      %E{indent: 0, type: 'h1', text: text },
    ]
  end
end
