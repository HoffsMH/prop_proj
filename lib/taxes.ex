defmodule Taxes do
  def call(args) do
    args
    |> new_taxes()
    |> new_total()
  end

  def new_taxes(args = %{taxes: taxes, tax_percent_inc: increase}) do
    %{args | taxes: taxes * increase}
  end

  def new_total(args = %{taxes: taxes, total_taxes_collected: total}) do
    %{args | total_taxes_collected: taxes + total}
  end

  def new_total(args) do
    new_total(Map.put(args, :total_taxes_collected, 0))
  end
end
