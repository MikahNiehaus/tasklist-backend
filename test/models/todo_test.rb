require "test_helper"

class TodoTest < ActiveSupport::TestCase
  def setup
    @todo = Todo.new(title: "Test Task", description: "This is a test task", completed: false)
  end

  test "should be valid with valid attributes" do
    assert @todo.valid?
  end

  test "should be invalid without a title" do
    @todo.title = nil
    assert_not @todo.valid?
  end

  test "should be invalid if title is too long" do
    @todo.title = "a" * 256
    assert_not @todo.valid?
  end

  test "should be valid without a description" do
    @todo.description = nil
    assert @todo.valid?
  end

  test "should be invalid if description is too long" do
    @todo.description = "a" * 1001
    assert_not @todo.valid?
  end

  test "should be invalid if completed is not true or false" do
    @todo.completed = nil
    assert_not @todo.valid?
  end
end
