class Project < ActiveRecord::Base
  
  is_sluggable :name
  
  scope :published, lambda { where('published_at IS NOT NULL AND published_at <= ?', Time.now) }
  scope :ordered_with_unpublished_first, order('(published_at IS NULL) DESC, published_at DESC')
  scope :ordered, order('published_at DESC')
  
  validates_presence_of :name, :description, :format
  validate              :ensure_has_valid_format
  
  before_save :render_sections
  
  def has_github_info?
    github_user.present? && github_repository.present?
  end
  
  protected
  
  def render_sections
    ContentRenderer.new(self, :description).render if rendered_description.blank? || format_changed? || description_changed?
  end
  
  def ensure_has_valid_format
    errors.add :format, :invalid_format unless ContentRenderer.valid_format?(format)
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

