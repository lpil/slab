defmodule Slab.Lexer do
  @moduledoc """
  Leex based lexing of Slab documents. See `src/slab_lexer.xrl` for details.
  """

  def tokenize!(document) when is_binary(document) do
    document |> to_char_list |> tokenize!
  end

  def tokenize!(document) when is_list(document) do
    {:ok, tokens, _} = document |> :slab_lexer.string
    tokens
  end
end
