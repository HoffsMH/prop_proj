defmodule Taxes do
  def call(args) do
    args
    |> new_taxes()
    |> new_total()
    |> new_tax_break()
  end

  def new_taxes(args = %{taxes: taxes, tax_percent_inc: increase}) do
    %{args | taxes: taxes * increase}
  end

  def new_total(args = %{taxes: taxes, total_taxes_collected: total}) do
    %{args | total_taxes_collected: taxes + total}
  end

  def new_tax_break(args = %{interest_collected: interest_collected, tax_break: _tax_break}) do
    new_tax_break = interest_collected * 0.24
    %{args | tax_break: new_tax_break}
  end

  def new_total(args) do
    args
    |> Map.put(:total_taxes_collected, 0)
    |> Map.put(:tax_break, 0)
    |> new_total()
  end
end
