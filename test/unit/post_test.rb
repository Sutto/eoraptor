require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  cached_slug  :string(255)
#  state        :string(255)
#  published_at :datetime
#  summary      :text
#  content      :text
#  created_at   :datetime
#  updated_at   :datetime
#

