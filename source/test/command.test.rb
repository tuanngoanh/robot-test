require 'test/unit'
require_relative '../command'

class CommandTest < Test::Unit::TestCase  
  # def setup
  # end

  # def teardown
  # end

  # ------------------------------------------------
  # test valid commands: MOVE, LEFT, RIGHT, REPORT
  # ------------------------------------------------

  def test_valid_command_move()
    assert_true(Command.valid?('MOVE'))
  end

  def test_valid_command_left()
    assert_true(Command.valid?('LEFT'))
  end

  def test_valid_command_right()
    assert_true(Command.valid?('RIGHT'))
  end

  def test_valid_command_report()
    assert_true(Command.valid?('REPORT'))
  end

  # ------------------------------------------------
  # test invalid commands
  # ------------------------------------------------

  def test_invalid_command_move_with_lower_characters()
    assert_false(Command.valid?('Move'))
  end

  def test_invalid_command_move_with_space()
    assert_false(Command.valid?('MOVE 123'))
  end

  def test_invalid_command_move_with_random_string()
    assert_false(Command.valid?('TESTABCD'))
  end

  # ------------------------------------------------
  # test valid commands: PLACE
  # ------------------------------------------------

  def test_valid_command_place()
    assert_true(Command.valid?('PLACE 1,2,NORTH'))
  end

  def test_valid_command_place_with_spaces()
    assert_true(Command.valid?('PLACE 100, 130,   SOUTH'))
  end

  # ------------------------------------------------
  # test valid commands: PLACE
  # ------------------------------------------------

  def test_valid_command_place_with_invalid_prefix()
    assert_false(Command.valid?('PLACEEE 1,2,NORTH'))
  end

  def test_valid_command_place_without_param()
    assert_false(Command.valid?('PLACE '))
  end

  def test_valid_command_place_with_negative_x_position()
    assert_false(Command.valid?('PLACE -1, 2, WEST'))
  end

  def test_valid_command_place_with_negative_y_position()
    assert_false(Command.valid?('PLACE 100, -2, EAST'))
  end

  def test_valid_command_place_with_2_params()
    assert_false(Command.valid?('PLACE 1,2'))
  end

  def test_valid_command_place_with_5_params()
    assert_false(Command.valid?('PLACE 1,2,3,4,5'))
  end

  def test_valid_command_place_with_x_position_is_nan()
    assert_false(Command.valid?('PLACE a,2,NORTH'))
  end

  def test_valid_command_place_with_y_position_is_nan()
    assert_false(Command.valid?('PLACE 10,ABC,NORTH'))
  end

  def test_valid_command_place_with_face_param_invalid()
    assert_false(Command.valid?('PLACE 1,2,ABCD'))
  end

  # ------------------------------------------------
  # test valid commands: common cases
  # ------------------------------------------------

  def test_valid_command_with_special_characters()
    assert_false(Command.valid?('*&@#$%^&*('))
  end

  # ------------------------------------------------
  # test get valid PLACE params function
  # ------------------------------------------------

  def test_valid_place_params()
    assert_equal([1,2,0], Command.place_params('PLACE 1,2,NORTH'))
  end

  def test_valid_place_params_with_0_position()
    assert_equal([0,0,3], Command.place_params('PLACE 0,0,WEST'))
  end

  def test_valid_place_params_with_no_space()
    assert_equal([1,2,2], Command.place_params('PLACE1,2,SOUTH'))
  end

  def test_valid_place_params_with_big_number()
    assert_equal([999999999,555555555,2], Command.place_params('PLACE 999999999,555555555,SOUTH'))
  end

  # ------------------------------------------------
  # test get invalid PLACE params function
  # ------------------------------------------------

  def test_invalid_place_params_with_negative_positions()
    assert_equal([], Command.place_params('PLACE -1,2,SOUTH'))
  end

  def test_invalid_place_params_with_invalid_face_value()
    assert_equal([], Command.place_params('PLACE -1,2,ABC'))
  end

  def test_invalid_place_params_with_no_param()
    assert_equal([], Command.place_params('PLACE'))
  end

  def test_invalid_place_params_with_2_param()
    assert_equal([], Command.place_params('PLACE -1,NORTH'))
  end

  def test_invalid_place_params_with_more_than_3_param()
    assert_equal([], Command.place_params('PLACE -1,,2,3,4,NORTH'))
  end
  
end