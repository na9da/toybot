require "test_helper"

class BotTest < MiniTest::Test
  def setup
    @bot = Toybot::Bot.new(Toybot::Table.new 5,5)
  end

  def test_it_can_be_placed_on_the_table
    @bot.place(x:3, y:2, direction: :NORTH)
    assert_equal 3, @bot.x
    assert_equal 2, @bot.y
    assert_equal :NORTH, @bot.direction
  end

  def test_it_can_be_moved_forward
    @bot.place(x:0, y:0, direction: :NORTH)
    @bot.move_forward
    assert_equal 0, @bot.x
    assert_equal 1, @bot.y
    assert_equal :NORTH, @bot.direction
  end

  def test_it_can_be_turned_left
    @bot.place(x:0, y:0, direction: :NORTH)
    @bot.turn_left
    assert_equal :WEST, @bot.direction
    @bot.turn_left
    assert_equal :SOUTH, @bot.direction
    @bot.turn_left
    assert_equal :EAST, @bot.direction
    @bot.turn_left
    assert_equal :NORTH, @bot.direction
  end

  def test_it_can_be_turned_right
    @bot.place(x:0, y:0, direction: :NORTH)
    @bot.turn_right
    assert_equal :EAST, @bot.direction
    @bot.turn_right
    assert_equal :SOUTH, @bot.direction
    @bot.turn_right
    assert_equal :WEST, @bot.direction
    @bot.turn_right
    assert_equal :NORTH, @bot.direction
  end

  def test_it_can_report_its_position
    @bot.report_position
  end

  def test_it_discards_commands_that_pushes_it_off_the_table
    @bot.place(x:0, y:0, direction: :NORTH)
    @bot.turn_left
    @bot.move_forward
    @bot.move_forward
    assert_equal :WEST, @bot.direction
    assert_equal 0, @bot.x
    assert_equal 0, @bot.y
  end
  
  def test_it_can_exec_a_command
    cmd = Toybot::Command.new
    cmd.name = :PLACE
    cmd.args = { x: 3, y: 3, direction: :WEST }
    @bot.exec cmd
    assert_equal 3, @bot.x
    assert_equal 3, @bot.y
    assert_equal :WEST, @bot.direction
  end
  
  def test_if_not_placed_it_should_discard_the_command
    cmd = Toybot::Command.new
    cmd.name = :MOVE
    assert (@bot.exec cmd) == false
  end
end
