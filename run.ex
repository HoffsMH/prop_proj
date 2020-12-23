property_appreciation = 1.032
home_cost = 290_000
investment_cost = 298_693
starting_taxes = 7840
tax_percent_inc = 1.03
loan_principle = 230400
payment = 925.40
interest_rate = 0.0263
starting_insurance = 1000

result = PropProj.call(%{
      years: 10,
      appreciation: property_appreciation,
      home_cost: home_cost,
      investment_cost: investment_cost,
      taxes: starting_taxes,
      tax_percent_inc: tax_percent_inc,
      interest_rate: interest_rate,
      payment: payment,
      principle: loan_principle,
      insurance: starting_insurance,
      expected_rent: 1500
    })

import Reporting

main_header = "home cost, investment_cost, starting_loan_principle, loan_payment, loan_interest_rate, property_appreciation, starting_taxes, tax_percent_increase_per_year, starting_insurance_premium"

main_line = "#{fm(home_cost)}, #{fm(investment_cost)}, " <>
            "#{fm(loan_principle)}, #{fm(payment)}, #{interest_rate}, " <>
            "#{property_appreciation}, #{fm(starting_taxes)}, " <>
            "#{tax_percent_inc}, #{fm(starting_insurance)}, "


log_header = "year, sell_price, balance, balance_per_year, balance_per_year_per_month, taxes, taxes_payed, interest, interest_payed, insurance, insurance_payed, broker_fees_if_sold, tax_break_if_sold"

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
IO.inspect([main_header] ++ [main_line])

report = [main_header] ++ [main_line] ++ [""] ++ [log_header] ++ log_report
  |> Enum.join("\n")

{:ok, file} = File.open("report.csv", [:write])
IO.binwrite(file, report)
File.close(file)
