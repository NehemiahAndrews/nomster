require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "Convert to humanized rating" do
    actual = Comment.new(:rating => '1_star').humanized_rating
    expected = 'one star'

    assert_equal expected, actual
  end
end
