defmodule Reporting do
  def fm(num) do
    :erlang.float_to_binary(num, decimals: 2)
  end
end
