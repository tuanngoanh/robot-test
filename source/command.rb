require_relative 'direction'

class Command

    def self.valid?(command)
        return true if %w(REPORT LEFT RIGHT MOVE).include?(command)
        return valid_place_command?(command)
    end

    def self.place_params(command)
        cmdParams = command.gsub('PLACE', '').split(',')

        return [] if cmdParams.length != 3
        
        p1 = cmdParams[0].gsub(/\s+/, "") 
        p2 = cmdParams[1].gsub(/\s+/, "") 
        p3 = cmdParams[2].gsub(/\s+/, "")

        return [] if !posity_number?(p1) || !posity_number?(p2) || !DIRECTION.keys.include?(p3)

        [p1.to_i, p2.to_i, DIRECTION[p3]]
    end

    private 

    def self.valid_place_command?(command)
        return false if command.index('PLACE') != 0
        return place_params(command) != []
    end

    def self.posity_number?(str)
        temp = str.to_i
        temp >= 0 && temp.to_s == str
    end
end