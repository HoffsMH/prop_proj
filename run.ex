result = PropProj.call(%{
      years: 10,
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

import Reporting

log_header =  "year, sell_price, balance, balance_per_year, balance_per_year_per_month, taxes, taxes_payed, interest, interest_payed, insurance, insurance_payed, broker_fees_if_sold, tax_break_if_sold"

log_report =
  result.logs
  |> Enum.reduce([], fn year, lines ->
    line = "#{year.current_year}, #{fm(year.sell_price)}, " <>
           "#{fm(year.balance)}, #{fm(year.balance / year.current_year)}, " <>
           "#{fm(year.balance / year.current_year / 12.0)}, " <>
           "#{fm(year.taxes)}, #{fm(year.total_taxes_collected)}, " <>
           "#{fm(year.interest)}, #{fm(year.interest_collected)}, " <>
           "#{fm(year.insurance)}, #{fm(year.insurance_collected)}, " <>
           "#{fm(year.sell_price * 0.06)}, #{fm(year.tax_break)}"

    lines ++ [line]
  end)

IO.inspect([log_header] ++ log_report)
