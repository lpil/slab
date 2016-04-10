defmodule Slab.ParserElement do
  @moduledoc """
  A node in the HTML. One per line.
  """

  defstruct indent: 0,
            type:   'div',
            text:   '',
            labels: [],
            attributes: []
end
