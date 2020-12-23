defmodule Reporting do
  def fm(num) do
    :erlang.float_to_binary(num / 1, decimals: 2)
  end
end
