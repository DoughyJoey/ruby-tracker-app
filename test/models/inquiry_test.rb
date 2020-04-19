require 'test_helper'

class InquiryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "must not save a inquiry when firstname lastname and email
    are not provided" do
    inquiry = Inquiry.new(firstname: "John",
    email: "john.davidson@email.ie")
    assert_equal(false, inquiry.save, "saved the customer even
    though at least one of the forename,
    surname and/or email were not provided!")
  end
end
