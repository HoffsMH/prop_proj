defmodule Interest do
  def payment_formula(%{p: p, i: i, n: n}) do
    x = 1 + i
    top = i * :math.pow(x, n)
    bottom = :math.pow(x, n) - 1.0

    p * (top / bottom)
  end

  def collected_for_year(payment, interest_rate, starting_principle) do
    starting_params = %{
      principle: starting_principle,
      interest_collected: 0,
      interest_rate: interest_rate,
      payment: payment
    }

    1..12
    |> Enum.reduce(starting_params, &increment_principle/2)
  end

  def increment_principle(_month, %{
        principle: principle,
        interest_collected: interest_collected,
        interest_rate: interest_rate,
        payment: payment
      }) do
    interest = interest_rate / 12.0 * principle

    %{
      interest_collected: interest_collected + interest,
      principle: principle - (payment - interest),
      interest_rate: interest_rate,
      payment: payment
    }
  end

  def call(
        args = %{
          interest_rate: interest_rate,
          payment: payment,
          principle: principle,
          interest_collected: interest_collected
        }
      ) do
    %{
      interest_collected: this_years_interest_collected,
      principle: new_principle
    } = collected_for_year(payment, interest_rate, principle)

    %{
      args
      | principle: new_principle,
        interest_collected: this_years_interest_collected + interest_collected
    }
  end

  def call(args) do
    call(Map.put(args, :interest_collected, 0))
  end
end
