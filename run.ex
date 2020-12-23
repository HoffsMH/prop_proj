result = PropProj.call(%{
      years: 6,
      appreciation: 1.034,
      home_cost: 290_000,
      investment_cost: 298_693,
      taxes: 7840,
      tax_percent_inc: 1.03,
      interest_rate: 0.0263,
      payment: 925.40,
      principle: 230400,
      number_of_payments: 360,
      insurance: 1000
    })

tax_break = result.interest_collected * 0.25

IO.puts("x = #{x}")

balance = result.sell_price * 0.94 - (result.investment_cost + result.total_taxes_collected + result.interest_collected + result.insurance_collected) + tax_break

IO.puts("balance: #{balance}")
IO.puts("over 6 years #{balance/6.0}")
IO.puts("per month #{balance/6.0/12.0}")
IO.puts("insurance collected: #{result.insurance_collected}")

#balance is sell_price - (investment_cost + broker_fees + taxes_payed + interest_payed + insurance_payed) + tax_break

# property_appreciation_per_year, loan_interest_rate, tax_increase_per_year, investment_cost, final_balance_if_sold_on_final_year,

# year sell_price, taxes, taxes_payed, interest, interest_payed, insurance, insurance_payed, broker_fees_if_sold, tax_break_if_sold
