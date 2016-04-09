defmodule Slab.Element do
  @moduledoc """
  A node in the HTML tree
  """

  defstruct indent:   0,
            type:     'div',
            labels:   [],
            children: []
end
