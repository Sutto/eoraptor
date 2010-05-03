class Project < ActiveRecord::Base
  
  is_publishable
  is_convertable :description
  is_sluggable   :name
  
  validates_presence_of :name, :description, :short_description
  
  def has_github_info?
    github_user.present? && github_repository.present?
  end
  
  def github_url
    return unless has_github_info?
    "http://github.com/#{github_user}/#{github_repository}"
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
#  cached_slug          :string(255)
#  format               :string(255)
#

