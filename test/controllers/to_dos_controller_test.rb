require 'test_helper'

class ToDosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get to_dos_index_url
    assert_response :success
  end

end
