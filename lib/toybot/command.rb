module Toybot

  class InvalidCommand < StandardError
  end

  #
  # Command class parses a line of command passed
  #
  class Command
    attr_accessor :name, :args

    def self.parse(s)
      Command.new.parse(s)
    end

    def parse(cmd)
      name, argstr = cmd.split(" ", 2)
      args =
        case name&.to_sym
        when :PLACE then parse_place(argstr)
        when :MOVE  then nil
        when :LEFT  then nil
        when :RIGHT then nil
        when :REPORT then nil
        else
          raise InvalidCommand
        end
      @name = name&.to_sym
      @args = args
      self
    end

    def to_s
      name = @name.to_s.upcase
      args = @args&.values&.join(",")
      "#{name} #{args}"
    end
    
    private
    def parse_place(argstr)
      x, y, dir = argstr.strip.split(",", 3)
      { x: parse_int(x), y: parse_int(y), direction: parse_direction(dir) }
    end

    def parse_int(s)
      Integer(s)
    rescue ArgumentError
      raise InvalidCommand, "expected int, got #{s}"
    end

    def parse_direction(s)
      sym = s&.to_sym
      if %i(NORTH SOUTH EAST WEST).include?(sym)
        sym
      else
        raise InvalidCommand, "expected direction, got #{s}"
      end
    end
    
  end
end
