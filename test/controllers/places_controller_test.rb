require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
 
  test "index" do
    place = FactoryGirl.create(:place)
    get :index

    assert_response :ok
  end

  test "show place page, found" do
    place = FactoryGirl.create(:place)
    get :show, :id => place.id

    assert_response :success
  end

  test "show place page, not found" do
    get :show, :id => 'OMG'

    assert_response :not_found
  end

  test "edit signed in, correct user" do
    place = FactoryGirl.create(:place)
    sign_in place.user

    get :edit, :id => place.id

    assert_response :success
  end

  test "edit signed in, incorrect correct user" do
    user = FactoryGirl.create(:user)
    sign_in user

    place = FactoryGirl.create(:place)
    get :edit, :id => place.id

    assert_response :forbidden
  end

  test "edit not signed in" do
    place = FactoryGirl.create(:place)
    get :edit, :id => place.id

    assert_redirected_to new_user_session_path
  end

  test "update signed in, correct user" do
    place = FactoryGirl.create(:place)
    sign_in place.user

      put :update, :id => place.id, :place => {
      :name => 'Home',
      :address => '1483 Crooked Lane',
      :description => 'The Original'
    }

    assert_redirected_to root_path
  end

  test "update signed in, incorrect user" do
    user = FactoryGirl.create(:user)
    sign_in user

    place = FactoryGirl.create(:place)

      put :update, :id => place.id, :place => {
      :name => 'Home',
      :address => '1483 Crooked Lane',
      :description => 'The Original'
    }
    
    assert_response :forbidden
  end

  test "update not signed in" do
    place = FactoryGirl.create(:place)

      put :update, :id => place.id, :place => {
      :name => 'Home',
      :address => '1483 Crooked Lane',
      :description => 'The Original'
    }
    
    assert_redirected_to new_user_session_path
  end

  test "destroy signed in, owner" do
    place = FactoryGirl.create(:place)
    sign_in place.user

    delete :destroy, :id => place.id

    assert_redirected_to root_path
  end

  test "destroy not signed in" do
    place = FactoryGirl.create(:place)
    delete :destroy, :id => place.id
    
    assert_redirected_to new_user_session_path
  end

  test "destroy, incorrect user" do
    user = FactoryGirl.create(:user)
    sign_in user

    place = FactoryGirl.create(:place)
    delete :destroy, :id => place.id

    assert_response :forbidden
  end

 test "create, signed in" do 
    user = FactoryGirl.create(:user)
    sign_in user

    assert_difference 'Place.count' do
      post :create, :place => {
        :name => 'Home',
        :address => '1483 Crooked Lane',
        :description => 'The Original'
      }
    end
    place = Place.last
    assert_equal place.name, 'Home'
    assert_redirected_to root_path
    assert_equal 1, user.places.count
 end

 test "create not signed in" do
    post :create, :place => {
        :name => 'Home',
        :address => '1483 Crooked Lane',
        :description => 'The Original'
      }
    assert_redirected_to new_user_session_path
 end

 test "create invalid" do
  user = FactoryGirl.create(:user)
  sign_in user

  assert_no_difference 'Place.count' do
    post :create, :place => {
      :name => 'Home',
      :description => 'The Original'
    }
  end

  assert_response :unprocessable_entity
  end

  test "new, signed in" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :new
    assert_response :success
  end

  test "new, not signed in" do
    get :new
    assert_redirected_to new_user_session_path
  end

end
