defmodule Slab.Element do
  @moduledoc """
  A node in the HTML tree
  """

  defstruct type:   'div',
            labels: [],
            indent: 0
end
