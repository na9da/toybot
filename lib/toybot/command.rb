module Toybot

  class InvalidCommand < StandardError
  end

  #
  # Command class parses a line of command
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
      _, x, y, dir = argstr.strip.match(/^(\d+),(\d+),(NORTH|SOUTH|EAST|WEST)$/).to_a
      { x: Integer(x), y: Integer(y), direction: dir.to_sym }
    rescue TypeError
      raise InvalidCommand
    end
  end
end
