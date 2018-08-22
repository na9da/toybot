require "test_helper"

class CommandTest < MiniTest::Test
  def setup
    @cmd = Toybot::Command.new
  end
  
  def test_it_can_parse_place_command
    @cmd.parse("PLACE 3,2,NORTH")
    assert @cmd.name == :PLACE
    assert @cmd.args[:x] == 3
    assert @cmd.args[:y] == 2
    assert @cmd.args[:direction] == :NORTH
  end

  def test_it_can_parse_move_command
    @cmd.parse("MOVE")
    assert @cmd.name == :MOVE
  end

  def test_it_can_parse_left_command
    @cmd.parse("LEFT")
    assert @cmd.name == :LEFT
  end

  def test_it_can_parse_right_command
    @cmd.parse("RIGHT")
    assert @cmd.name == :RIGHT
  end

  def test_it_can_parse_report_command
    @cmd.parse("REPORT")
    assert @cmd.name == :REPORT
  end
  
  def test_it_raises_an_error_for_invalid_command
    assert_raises Toybot::InvalidCommand do
      @cmd.parse("THIS should,raise,error")
    end
  end
end


