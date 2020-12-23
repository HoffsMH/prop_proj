# years = 6

# profit =
#   Sim.call(%{
#     years: years,
#     appreciation: 1.034,
#     home_cost: 297_000,
#     investment_cost: 303_000,
#     sell_price: 0,
#     starting_tax_rate: 0.0256,
#     tax_rate: 0,
#     taxes_collected: 0,
#     interest_per_year: 6200,
#     interest_collected: 0
#   })

# IO.puts("")
# IO.puts("profit ----")
# IO.puts("")
# IO.puts(profit)

# IO.puts("")
# IO.puts("in rent ----")
# IO.puts("")
# IO.puts(profit / years / 12)
# IO.puts("")

# IO.puts("")
# IO.puts("vs my 1700 in NY ----")
# IO.puts("")
# IO.puts("out of pocket #{1700 * 12 * years}")
# IO.puts("difference = ")
# IO.puts("#{1700 * 12 * years + profit}")

# desert_quail_taxes = [
#   3348,
#   3459,
#   3427,
#   3394,
#   3552,
#   3559,
#   3600,
#   3738,
#   3785,
#   4237,
#   4667,
#   5129
# ]

# x =
#   desert_quail_taxes
#   |> Enum.with_index()
#   |> Enum.map(fn {v, i} ->
#     if i == 0 do
#       0
#     else
#       Enum.at(desert_quail_taxes, i - 1) / v - 1
#     end
#   end)
#   |> IO.inspect()
#   |> Enum.sum()

# IO.inspect(x / (Enum.count(desert_quail_taxes) - 1))

# willow_city = [
#   3972,
#   4003,
#   3704,
#   4040,
#   4042,
#   4045,
#   4365,
#   4712,
#   5217,
#   5681,
#   5687,
#   5828
# ]

# y =
#   willow_city
#   |> Enum.with_index()
#   |> Enum.map(fn {v, i} ->
#     if i == 0 do
#       0
#     else
#       Enum.at(willow_city, i - 1) / v - 1
#     end
#   end)
#   |> IO.inspect()
#   |> Enum.sum()

# IO.inspect(y / (Enum.count(willow_city) - 1))
