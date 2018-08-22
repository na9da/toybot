require "test_helper"

class ToybotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Toybot::VERSION
  end
end
