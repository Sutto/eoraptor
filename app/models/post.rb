class Post < ActiveRecord::Base
  
  validates_presence_of :title, :content
  
  is_sluggable :title
  
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

