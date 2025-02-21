# make better 
require "test_helper"
require "mocha/minitest"  
class TodosControllerTest < ActiveSupport::TestCase
  setup do
    @controller = TodosController.new

    # ✅ Mock Room (No ActiveRecord dependency)
    @mock_room = mock("Room")
    @mock_room.stubs(:room_code).returns("TESTROOM")

    @controller.instance_variable_set(:@room, @mock_room)
    @controller.instance_variable_set(:@table_name, "todos_TESTROOM")

    # ✅ Completely Mock ActiveRecord to Prevent DB Calls
    ActiveRecord::Base.stubs(:connection).raises("Database should not be accessed in unit tests!")

    # ✅ Mock a fake todo object
    @mock_todo = { "id" => 1, "title" => "Test Todo", "description" => "A test", "completed" => false }
  end

  test "should define index action" do
    assert_respond_to @controller, :index
  end

  test "should define create action" do
    assert_respond_to @controller, :create
  end

  test "should define update action" do
    assert_respond_to @controller, :update
  end

  test "should define destroy action" do
    assert_respond_to @controller, :destroy
  end

  test "should define toggle action" do
    assert_respond_to @controller, :toggle
  end
end
