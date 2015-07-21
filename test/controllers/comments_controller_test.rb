require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
   
   test "create" do
    user = FactoryGirl.create(:user)
    sign_in user

    place = FactoryGirl.create(:place, :user => user)
    
    assert_difference 'Comment.count' do
      post :create, :place_id => place.id, :comment => {
        :message => 'Awesome',
        :rating => '5_stars'
      }    
    end

    assert_redirected_to place_path(place)
    assert_equal 1, user.comments.count
   end

   test "create not signed in" do 
    place = FactoryGirl.create(:place)
    
    assert_no_difference 'Comment.count' do
      post :create, :place_id => place.id, :comment => {
        :message => 'Awesome',
        :rating => '5_stars'
      }    
    end
    assert_redirected_to new_user_session_path
   end

   test "create invalid" do
    user = FactoryGirl.create(:user)
    sign_in user

    place = FactoryGirl.create(:place, :user => user)
    
    post :create, :place_id => place.id, :comment => {
        :message => 'Awesome'
      }    
    

    assert_response :unprocessable_entity
    
   end

   
end
