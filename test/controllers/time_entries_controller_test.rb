require "test_helper"

class TimeEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get time_entries_create_url
    assert_response :success
  end

  test "should get index" do
    get time_entries_index_url
    assert_response :success
  end
end
