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

  def new_broker_fees(args = %{broker_fees: _, sell_price: sell_price}) do
    %{args | broker_fees: sell_price * 0.06}
  end

  def new_broker_fees(args) do
    Map.put(args, :broker_fees, 0)
    |> new_broker_fees()
  end

  def new_balance(
        args = %{
          sell_price: sp,
          investment_cost: ic,
          broker_fees: bf,
          total_taxes_collected: tc,
          interest_collected: icl,
          insurance_collected: inscl,
          tax_break: tb,
          balance: _
        }
      ) do
    new_balance = sp - (ic + bf + tc + icl + inscl) + tb
    %{args | balance: new_balance}
  end

  def new_balance(args) do
    args
    |> Map.put(:balance, 0)
    |> new_balance()
  end

  def new_rent_advantage(
        args = %{
          appreciation: appreciation,
          expected_rent: expected_rent,
          balance: balance,
          current_year: current_year,
          rent_advantage: _
        }
      ) do
    new_expected_rent = expected_rent * appreciation
    IO.puts "new expected rent: #{new_expected_rent}"
    rent_advantage = new_expected_rent + (balance / current_year / 12.0)
    %{args | rent_advantage: rent_advantage, expected_rent: new_expected_rent}
  end

  def new_rent_advantage(args) do
    args
    |> Map.put(:rent_advantage, 0)
    |> new_rent_advantage()
  end

  def call(args) do
    args
    |> new_year()
    |> new_sell_price()
    |> Interest.call()
    |> Taxes.call()
    |> new_insurance()
    |> new_broker_fees()
    |> new_balance()
    # |> new_rent_advantage()
    |> new_log()
    |> call()
  end
end
