require "test_helper"

class TableTest < MiniTest::Test
  def test_it_returns
    table = Toybot::Table.new(10,10)
    assert table.on?(3, 4)
    assert table.on?(20, 20) == false
  end
end
