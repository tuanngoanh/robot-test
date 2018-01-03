require 'test/unit'
require 'test/unit/ui/console/testrunner'
require_relative 'command.test'
require_relative 'robot.test'

class AllTests
  def self.suite
    suite = Test::Unit::TestSuite.new
    suite << CommandTest.suite
    suite << RobotTest.suite
    return suite
  end
end

Test::Unit::UI::Console::TestRunner.run(AllTests)