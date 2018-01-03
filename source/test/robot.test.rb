gem 'test-unit'
require 'test/unit'
require_relative '../robot'

class RobotTest < Test::Unit::TestCase  

  def setup
    @robot = Robot.new(5)
  end

  # def teardown
  # end

  # ------------------------------------------------
  # test robot will not move or rotate if not ready
  # ------------------------------------------------

  def test_initiate_value()
    assert_equal(-1, @robot.x)
  end

  def test_robot_wont_move_until_it_is_ready()
    @robot.move
    assert_equal(-1, @robot.x)
    assert_equal(-1, @robot.y)
  end

  def test_robot_wont_rotate_until_it_is_ready()
    @robot.rotate_left
    assert_equal(-1, @robot.face)

    @robot.rotate_right
    assert_equal(-1, @robot.face)
  end

  # ------------------------------------------------
  # test robot will not report if not ready
  # ------------------------------------------------
  def test_robot_wont_report_until_it_is_ready()
    assert_false(@robot.report)
  end

  # ------------------------------------------------
  # test robot will report if ready
  # ------------------------------------------------
  def test_robot_will_report_if_it_is_ready()
    @robot.place(2,2,DIRECTION['EAST'])
    assert_true(@robot.report)
  end

  # ------------------------------------------------
  # test invalid PLACE function
  # ------------------------------------------------

  def test_robot_will_not_update_position_if_new_position_is_out_of_table()
    @robot.place(5,2,DIRECTION['EAST'])
    assert_equal(-1, @robot.x)
    assert_equal(-1, @robot.y)
  end

  def test_robot_will_not_update_position_if_new_position_is_negative_number()
    @robot.place(-2,2,DIRECTION['EAST'])
    assert_equal(-1, @robot.x)
    assert_equal(-1, @robot.y)
  end
  # ------------------------------------------------
  # test valid PLACE function
  # ------------------------------------------------
  def test_robot_will_update_position_if_new_position_is_valid()
    @robot.place(1,2,DIRECTION['EAST'])
    assert_equal(1, @robot.x)
    assert_equal(2, @robot.y)
    assert_equal(DIRECTION['EAST'], @robot.face)
  end

  # ------------------------------------------------
  # test valid TURN LEFT function
  # ------------------------------------------------
  def test_robot_will_turn_left_from_north_to_west_and_position_no_change()
    @robot.place(1,2,DIRECTION['NORTH'])
    @robot.rotate_left
    assert_equal(DIRECTION['WEST'], @robot.face)
    assert_equal(1, @robot.x)
    assert_equal(2, @robot.y)
  end

  def test_robot_will_turn_left_from_east_to_north()
    @robot.place(2,2,DIRECTION['EAST'])
    @robot.rotate_left
    assert_equal(DIRECTION['NORTH'], @robot.face)
  end

  def test_robot_will_turn_left_from_south_to_east()
    @robot.place(2,2,DIRECTION['SOUTH'])
    @robot.rotate_left
    assert_equal(DIRECTION['EAST'], @robot.face)
  end

  def test_robot_will_turn_left_from_west_to_south()
    @robot.place(2,2,DIRECTION['WEST'])
    @robot.rotate_left
    assert_equal(DIRECTION['SOUTH'], @robot.face)
  end

  # ------------------------------------------------
  # test valid TURN RIGHT function
  # ------------------------------------------------
  def test_robot_will_turn_right_from_noth_to_east_and_position_no_change()
    @robot.place(2,3,DIRECTION['NORTH'])
    @robot.rotate_right
    assert_equal(DIRECTION['EAST'], @robot.face)
    assert_equal(2, @robot.x)
    assert_equal(3, @robot.y)
  end

  def test_robot_will_turn_right_from_east_to_south()
    @robot.place(2,2,DIRECTION['EAST'])
    @robot.rotate_right
    assert_equal(DIRECTION['SOUTH'], @robot.face)
  end

  def test_robot_will_turn_right_from_south_to_west()
    @robot.place(2,2,DIRECTION['SOUTH'])
    @robot.rotate_right
    assert_equal(DIRECTION['WEST'], @robot.face)
  end

  def test_robot_will_turn_right_from_west_to_north()
    @robot.place(2,2,DIRECTION['WEST'])
    @robot.rotate_right
    assert_equal(DIRECTION['NORTH'], @robot.face)
  end

  # ------------------------------------------------
  # test valid MOVE function: up, down, left, right
  # ------------------------------------------------
  def test_robot_will_move_up_if_direction_is_north()
    @robot.place(2,2,DIRECTION['NORTH'])
    @robot.move
    assert_equal(2, @robot.x)
    assert_equal(3, @robot.y)
  end

  def test_robot_will_move_right_if_direction_is_east()
    @robot.place(2,2,DIRECTION['EAST'])
    @robot.move
    assert_equal(3, @robot.x)
    assert_equal(2, @robot.y)
  end

  def test_robot_will_move_down_if_direction_is_south()
    @robot.place(2,2,DIRECTION['SOUTH'])
    @robot.move
    assert_equal(2, @robot.x)
    assert_equal(1, @robot.y)
  end

  def test_robot_will_move_left_if_direction_is_west()
    @robot.place(2,2,DIRECTION['WEST'])
    @robot.move
    assert_equal(1, @robot.x)
    assert_equal(2, @robot.y)
  end

  # -----------------------------------------------------------
  # test invalid MOVE function: border - top, bottom, left, right
  # -----------------------------------------------------------
  def test_robot_will_not_move_up_if_new_position_is_out_of_table_in_top()
    @robot.place(3,4,DIRECTION['NORTH'])
    @robot.move
    assert_equal(3, @robot.x)
    assert_equal(4, @robot.y)
  end

  def test_robot_will_not_move_right_if_new_position_is_out_of_table_in_right()
    @robot.place(4,3,DIRECTION['EAST'])
    @robot.move
    assert_equal(4, @robot.x)
    assert_equal(3, @robot.y)
  end

  def test_robot_will_not_move_down_if_new_position_is_out_of_table_in_bottom()
    @robot.place(2,0,DIRECTION['SOUTH'])
    @robot.move
    assert_equal(2, @robot.x)
    assert_equal(0, @robot.y)
  end

  def test_robot_will_not_move_left_if_new_position_is_out_of_table_in_left()
    @robot.place(0,2,DIRECTION['WEST'])
    @robot.move
    assert_equal(0, @robot.x)
    assert_equal(2, @robot.y)
  end

end