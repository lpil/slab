defmodule Slab.Lexer do
  @moduledoc """
  Leex based lexing of Slab documents. See `src/slab_lexer.xrl` for details.
  """

  def tokenize!(document) when is_binary(document) do
    document
    |> strip_trailing_newlines
    |> to_char_list
    |> tokenize!
  end

  def tokenize!(document) when is_list(document) do
    {:ok, tokens, _} = document |> :slab_lexer.string
    tokens
  end


  defp strip_trailing_newlines(document) when is_binary(document) do
    String.replace( document, ~r/\n+\z/, "" )
  end
end
