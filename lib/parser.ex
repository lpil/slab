defmodule Slab.Parser do
  @moduledoc """
  Lexing and Parsing of Slab documents.

  See `Slab.Lexer` and `src/slab_parser.yrl` for details.
  """

  alias Slab.Lexer

  def parse!(document) when is_binary(document) do
    {:ok, tree} =
      document
      |> Lexer.tokenize!
      |> :slab_parser.parse
    tree
  end
end
