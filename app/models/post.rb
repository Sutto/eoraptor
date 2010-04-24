class Post < ActiveRecord::Base
  
  is_sluggable :title
  
  validates_presence_of :title, :content, :summary
  validate              :ensure_has_valid_format
  
  before_save :render_sections
  
  scope :published, lambda { where('published_at IS NOT NULL AND published_at <= ?', Time.now) }
  
  def published?
    published_at.present? && published_at < Time.now
  end
  
  protected
  
  def render_sections
    ContentRenderer.new(self, :content).render if format_changed? || content_changed?
    ContentRenderer.new(self, :summary).render if format_changed? || summary_changed?
  end
  
  def ensure_has_valid_format
    errors.add :format, :invalid_format unless ContentRenderer.valid_format?(format)
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

