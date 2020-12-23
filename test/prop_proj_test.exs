defmodule PropProjTest do
  use ExUnit.Case
  doctest PropProj

  def sample_args do
    years = 6

    %{
      years: years,
      appreciation: 1.034,
      home_cost: 290_000,
      investment_cost: 303_000,
      taxes: 6800,
      tax_percent_inc: 1.034,
      interest_rate: 0.0263,
      payment: 925.40,
      principle: 230_400,
      number_of_payments: 360
    }
  end

  test "&call" do
    with result <- PropProj.call(sample_args) do
      assert result.sell_price === 354_422.4557672311
      assert result == 0
    end
  end

  test "Interest.payment_formula/1" do
    result = Interest.payment_formula(%{i: 0.0263 / 12, p: 230_400, n: 360})
    assert result == 926.007524184688
  end

  test "Interest.collected_for_year/3" do
    result = Interest.collected_for_year(954.32, 0.0263, 237_600)

    result = Interest.collected_for_year(954.32, 0.0263, 232_333.86220056878)
    assert result.principle == 226_927.54322492547
    assert result.interest_collected == 6045.521024356689
  end
end
