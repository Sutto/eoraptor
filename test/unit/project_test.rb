require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: projects
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  description          :text
#  rendered_description :text
#  github_user          :string(255)
#  github_repository    :string(255)
#  website              :string(255)
#  published_at         :datetime
#  created_at           :datetime
#  updated_at           :datetime
#

