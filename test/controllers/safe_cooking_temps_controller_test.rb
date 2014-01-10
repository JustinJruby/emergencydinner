require 'test_helper'

class SafeCookingTempsControllerTest < ActionController::TestCase
  setup do
    @safe_cooking_temp = safe_cooking_temps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:safe_cooking_temps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create safe_cooking_temp" do
    assert_difference('SafeCookingTemp.count') do
      post :create, safe_cooking_temp: { group: @safe_cooking_temp.group, note: @safe_cooking_temp.note, temp: @safe_cooking_temp.temp, type: @safe_cooking_temp.type }
    end

    assert_redirected_to safe_cooking_temp_path(assigns(:safe_cooking_temp))
  end

  test "should show safe_cooking_temp" do
    get :show, id: @safe_cooking_temp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @safe_cooking_temp
    assert_response :success
  end

  test "should update safe_cooking_temp" do
    patch :update, id: @safe_cooking_temp, safe_cooking_temp: { group: @safe_cooking_temp.group, note: @safe_cooking_temp.note, temp: @safe_cooking_temp.temp, type: @safe_cooking_temp.type }
    assert_redirected_to safe_cooking_temp_path(assigns(:safe_cooking_temp))
  end

  test "should destroy safe_cooking_temp" do
    assert_difference('SafeCookingTemp.count', -1) do
      delete :destroy, id: @safe_cooking_temp
    end

    assert_redirected_to safe_cooking_temps_path
  end
end
