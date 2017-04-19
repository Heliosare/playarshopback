require 'test_helper'

class TargetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @target = targets(:one)
  end

  test "should get index" do
    get targets_url
    assert_response :success
  end

  test "should get new" do
    get new_target_url
    assert_response :success
  end

  test "should create target" do
    assert_difference('Target.count') do
      post targets_url, params: { target: { city: @target.city, discountChance: @target.discountChance, discountRate: @target.discountRate, image: @target.image, path: @target.path, place: @target.place, target_id: @target.target_id, transaction_id: @target.transaction_id, vuforia_name: @target.vuforia_name } }
    end

    assert_redirected_to target_url(Target.last)
  end

  test "should show target" do
    get target_url(@target)
    assert_response :success
  end

  test "should get edit" do
    get edit_target_url(@target)
    assert_response :success
  end

  test "should update target" do
    patch target_url(@target), params: { target: { city: @target.city, discountChance: @target.discountChance, discountRate: @target.discountRate, image: @target.image, path: @target.path, place: @target.place, target_id: @target.target_id, transaction_id: @target.transaction_id, vuforia_name: @target.vuforia_name } }
    assert_redirected_to target_url(@target)
  end

  test "should destroy target" do
    assert_difference('Target.count', -1) do
      delete target_url(@target)
    end

    assert_redirected_to targets_url
  end
end
