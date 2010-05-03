class Post < ActiveRecord::Base
  
  validates_presence_of :title, :content, :summary
  
  is_publishable
  is_convertable :content, :summary
  is_sluggable   :title
  
  scope :for_listing, select('title, cached_slug, published_at, id')
  
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

