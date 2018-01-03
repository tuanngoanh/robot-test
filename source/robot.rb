require_relative 'direction'

class Robot

    # current position & face direction
    attr_accessor :x, :y, :face

    # robot only takes action when this flag turns to false
    attr_accessor :robot_not_ready
    
    # length of moving area: this value will be assigned when initiate the robot
    attr_accessor :table_size

    protected :robot_not_ready, :table_size

    # constructor
    def initialize(table_size)
        self.x = -1
        self.y = -1
        self.face = -1
        self.table_size = table_size
        self.robot_not_ready = true
    end

    def place(x,y,face)
        # skip if position is invalid (out of the table)
        return if x < 0 || x >= self.table_size || y < 0 || y >= self.table_size
        self.x = x
        self.y = y
        self.face = face
        self.robot_not_ready = false
    end

    def rotate_left
        return if self.robot_not_ready
        self.face = (self.face + 3) % 4 # Decrease face value to 1 unit
    end

    def rotate_right
        return if self.robot_not_ready
        self.face = (self.face + 1) % 4 # Increase face value to 1 unit
    end

    def move
        return if self.robot_not_ready

        move_left   if self.face == DIRECTION['WEST']
        move_right  if self.face == DIRECTION['EAST']
        move_up     if self.face == DIRECTION['NORTH']
        move_down   if self.face == DIRECTION['SOUTH']
    end

    def report
        return false if self.robot_not_ready
        puts "#{self.x},#{self.y},#{DIRECTION.key(self.face)}"
        return true
    end


    private
    
    def move_up
        self.y += 1 if self.y < self.table_size - 1
    end

    def move_down
        self.y -= 1 if self.y > 0
    end

    def move_left
        self.x -= 1 if self.x > 0
    end

    def move_right
        self.x += 1 if self.x < self.table_size - 1
    end

end