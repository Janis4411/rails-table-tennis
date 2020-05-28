require 'test_helper'

class TableControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get table_index_url
    assert_response :success
  end

  test "should get show" do
    get table_show_url
    assert_response :success
  end

  test "should get create" do
    get table_create_url
    assert_response :success
  end

  test "should get new" do
    get table_new_url
    assert_response :success
  end

  test "should get update" do
    get table_update_url
    assert_response :success
  end

end
