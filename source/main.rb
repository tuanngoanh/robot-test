require_relative 'robot'
require_relative 'command'

TABLE_SIZE = 5

robot = Robot.new(TABLE_SIZE)

commands = IO.readlines(ARGV[0] || "data.txt")

commands.each do |command|

  command = command.gsub(/\s+/, "") # remove new line character

  next unless Command.valid?(command)

  case command
    when 'REPORT'
        robot.report 

    when 'LEFT'
        robot.rotate_left 

    when 'RIGHT'
        robot.rotate_right 

    when 'MOVE'
        robot.move

    else # 'PLACE'
        params = Command.place_params(command)
        robot.place(params[0], params[1], params[2])
  end
end

