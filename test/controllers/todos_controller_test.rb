require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get todos_path
    assert_response :success
  end

  test "should get show" do
    todo = todos(:one)
    get todo_path(todo)
    assert_response :success
  end

  test "should get new" do
    get new_todo_path
    assert_response :success
  end

  test "should get create" do
    post todos_path, params: { todo: { title: "Test Todo" } }
    assert_response :redirect
  end

  test "should get edit" do
    todo = todos(:one)
    get edit_todo_path(todo)
    assert_response :success
  end

  test "should get update" do
    todo = todos(:one)
    patch todo_path(todo), params: { todo: { title: "Updated Todo" } }
    assert_response :redirect
  end

  test "should get destroy" do
    todo = todos(:one)
    delete todo_path(todo)
    assert_response :redirect
  end
end
