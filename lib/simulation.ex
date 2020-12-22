defmodule Sim do
  def call(%{
        years: 0,
        sell_price: sell_price,
        home_cost: home_cost,
        investment_cost: investment_cost,
        taxes_collected: taxes_collected,
        interest_collected: interest_collected
      }) do
    sell_price * 0.94 - investment_cost - taxes_collected
  end

  def get_new_sell_price(args = %{ sell_price: 0, home_cost: home_cost, appreciation: appreciation }) do
    %{ args | new_sell_price: home_cost * appreciation }
  end

  def get_new_sell_price(args = %{ sell_price: sell_price, appreciation: appreciation }) do
    %{ args | new_sell_price: sell_price * appreciation }
  end

  def call(args = %{
        interest_collected: interest_collected,
        interest_per_year: interest_per_year,
        investment_cost: investment_cost,
        sell_price: sell_price,
        starting_tax_rate: starting_tax_rate,
        tax_rate: tax_rate,
        taxes_collected: taxes_collected,
        years: years
      }) do

    # %{ new_sell_price: new_sell_price } = get_new_sell_price(args)

    new_tax_rate =
      if tax_rate == 0 do
        starting_tax_rate * home_cost
      else
        tax_rate * 1.034
      end

    new_taxes_collected = new_tax_rate + taxes_collected
    new_interest_per_year = interest_per_year - 207

    new_interest_collected =
      if new_interest_per_year <= 0 do
        interest_collected
      else
        interest_per_year + interest_collected
      end

    IO.puts("---------------------year #{years} -----------------")
    IO.puts("")
    IO.puts("potential_sell_price: #{:erlang.float_to_binary(new_sell_price, decimals: 2)}")

    IO.puts(
      "an appreciation of: #{:erlang.float_to_binary(new_sell_price - sell_price, decimals: 2)}"
    )

    IO.puts("a tax hike of: #{:erlang.float_to_binary(new_tax_rate - tax_rate, decimals: 2)}")
    IO.puts("total_taxes_collected: #{new_taxes_collected}")
    IO.puts("this_years_prop_taxes: #{new_tax_rate}")
    IO.puts("total_interest_collected: #{new_interest_collected}")
    IO.puts("this_years_interest: #{interest_per_year}")

    call(%{
      interest_collected: new_interest_collected,
      interest_per_year: new_interest_per_year,
      investment_cost: investment_cost,
      sell_price: new_sell_price,
      starting_tax_rate: starting_tax_rate,
      tax_rate: new_tax_rate,
      taxes_collected: new_taxes_collected,
      years: years - 1
    })
  end
end

years = 6

profit =
  Sim.call(%{
    years: years,
    appreciation: 1.034,
    home_cost: 297_000,
    investment_cost: 303_000,
    sell_price: 0,
    starting_tax_rate: 0.0256,
    tax_rate: 0,
    taxes_collected: 0,
    interest_per_year: 6200,
    interest_collected: 0
  })

IO.puts("")
IO.puts("profit ----")
IO.puts("")
IO.puts(profit)

IO.puts("")
IO.puts("in rent ----")
IO.puts("")
IO.puts(profit / years / 12)
IO.puts("")

IO.puts("")
IO.puts("vs my 1700 in NY ----")
IO.puts("")
IO.puts("out of pocket #{1700 * 12 * years}")
IO.puts("difference = ")
IO.puts("#{1700 * 12 * years + profit}")

desert_quail_taxes = [
  3348,
  3459,
  3427,
  3394,
  3552,
  3559,
  3600,
  3738,
  3785,
  4237,
  4667,
  5129
]

x =
  desert_quail_taxes
  |> Enum.with_index()
  |> Enum.map(fn {v, i} ->
    if i == 0 do
      0
    else
      Enum.at(desert_quail_taxes, i - 1) / v - 1
    end
  end)
  |> IO.inspect()
  |> Enum.sum()

IO.inspect(x / (Enum.count(desert_quail_taxes) - 1))

willow_city = [
  3972,
  4003,
  3704,
  4040,
  4042,
  4045,
  4365,
  4712,
  5217,
  5681,
  5687,
  5828
]

y =
  willow_city
  |> Enum.with_index()
  |> Enum.map(fn {v, i} ->
    if i == 0 do
      0
    else
      Enum.at(willow_city, i - 1) / v - 1
    end
  end)
  |> IO.inspect()
  |> Enum.sum()

IO.inspect(y / (Enum.count(willow_city) - 1))
