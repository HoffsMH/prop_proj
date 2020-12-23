defmodule PropProj do
  def new_sell_price(args = %{sell_price: sell_price, appreciation: appreciation}) do
    %{args | sell_price: sell_price * appreciation}
  end

  def new_sell_price(args = %{home_cost: home_cost, appreciation: appreciation}) do
    Map.put(args, :sell_price, home_cost * appreciation)
  end

  def new_year(args = %{current_year: current}) do
    %{args | current_year: current + 1}
  end

  def new_year(args) do
    Map.put(args, :current_year, 1)
  end

  def call(args = %{current_year: current_year, years: years}) when current_year == years do
    args
  end

  def new_log(args = %{logs: logs}) do
    new_args = Map.delete(args, :logs)
    new_logs = logs ++ [new_args]

    Map.put(new_args, :logs, new_logs)
  end

  def new_log(args) do
    Map.put(args, :logs, [])
    |> new_log()
  end

  def new_insurance(args = %{insurance: insurance, insurance_collected: insurance_collected}) do
    new_insurance = insurance * 1.02

    %{args | insurance: new_insurance, insurance_collected: insurance_collected + new_insurance}
  end

  def new_insurance(args) do
    Map.put(args, :insurance_collected, 0)
    |> new_insurance()
  end

  def call(args) do
    args
    |> new_year()
    |> new_sell_price()
    |> Taxes.call()
    |> Interest.call()
    |> new_insurance()
    |> new_log()
    |> call()
  end
end
