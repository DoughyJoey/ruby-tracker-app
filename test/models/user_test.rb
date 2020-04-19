require 'test_helper'

class UserTest < ActiveSupport::TestCase
   #test "the truth" do
     #assert true
   #end
    
   test "must not save a user when firstname lastname and email
    are not provided" do
    user = User.new(first_name: "John",
    email: "john.davidson@email.ie")
    assert_equal(false, user.save, "saved the customer even
    though at least one of the forename,
    surname and/or email were not provided!")
   end
end
