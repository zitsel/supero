require 'test_helper'

class EbayListingsControllerTest < ActionController::TestCase
  setup do
    @ebay_listing = ebay_listings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ebay_listings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ebay_listing" do
    assert_difference('EbayListing.count') do
      post :create, ebay_listing: { ebay_item_id: @ebay_listing.ebay_item_id, end_time: @ebay_listing.end_time, insertion_fees: @ebay_listing.insertion_fees, item_id: @ebay_listing.item_id, start_time: @ebay_listing.start_time }
    end

    assert_redirected_to ebay_listing_path(assigns(:ebay_listing))
  end

  test "should show ebay_listing" do
    get :show, id: @ebay_listing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ebay_listing
    assert_response :success
  end

  test "should update ebay_listing" do
    patch :update, id: @ebay_listing, ebay_listing: { ebay_item_id: @ebay_listing.ebay_item_id, end_time: @ebay_listing.end_time, insertion_fees: @ebay_listing.insertion_fees, item_id: @ebay_listing.item_id, start_time: @ebay_listing.start_time }
    assert_redirected_to ebay_listing_path(assigns(:ebay_listing))
  end

  test "should destroy ebay_listing" do
    assert_difference('EbayListing.count', -1) do
      delete :destroy, id: @ebay_listing
    end

    assert_redirected_to ebay_listings_path
  end
end
