require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'when performing validations' do
    should_validate_presence_of :title, :summary, :content
    should_allow_values_for     :format, *AlmostHappy::Convertor.renderers.keys
    should_not_allow_values_for :format, "ninja-attack", 32, "Rock and Roll"
  end
end


# == Schema Information
#
# Table name: posts
#
#  id               :integer         not null, primary key
#  title            :string(255)
#  cached_slug      :string(255)
#  state            :string(255)
#  published_at     :datetime
#  format           :string(255)
#  summary          :text
#  rendered_summary :text
#  content          :text
#  rendered_content :text
#  created_at       :datetime
#  updated_at       :datetime
#

