module Toybot
  #
  # The bot class simulates the behavior of a bot placed on a table surface.
  # It can `exec` basic commands while ensuring it doesn't fall off the table
  #
  class Bot

    attr_reader :x, :y, :direction, :table
    
    def initialize(table)
      @table = table
      @placed = false
    end

    def exec(cmd)
      unless placed? || cmd.name == :PLACE
        return false
      end

      case cmd.name
      when :PLACE then place(**cmd.args)
      when :MOVE then move_forward
      when :LEFT then turn_left
      when :RIGHT then turn_right
      when :REPORT then report_position
      end
      
      true
    end

    def placed?
      @placed
    end
    
    def place(x:, y:, direction:)
      return unless table.on?(x, y)

      @x, @y, @direction = x, y, direction
      @placed = true
    end

    def move_forward
      newx, newy =
            case direction
            when :NORTH then [x, y + 1]
            when :SOUTH then [x, y - 1]
            when :EAST  then [x + 1, y]
            when :WEST  then [x - 1, y]
            end
      if table.on?(newx, newy)
        @x, @y = newx, newy
      end
    end

    def turn_left
      @direction =
        case @direction
        when :NORTH then :WEST
        when :SOUTH then :EAST
        when :EAST  then :NORTH
        when :WEST  then :SOUTH
        end
    end

    def turn_right
      @direction =
        case @direction
        when :NORTH then :EAST
        when :SOUTH then :WEST
        when :EAST  then :SOUTH
        when :WEST  then :NORTH
        end
    end

    def report_position
      puts "Output: #{x},#{y},#{direction}"      
    end
  end
end
