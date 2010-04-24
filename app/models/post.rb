class Post < ActiveRecord::Base
  
  is_sluggable :title
  
  validates_presence_of :title, :content, :summary
  validate              :ensure_has_valid_format
  
  before_save :render_sections
  
  scope :published,   lambda { where('published_at IS NOT NULL AND published_at <= ?', Time.now) }
  scope :ordered,     order('published_at DESC')
  scope :for_listing, select('title, cached_slug, published_at, id')
  
  def published?
    published_at.present? && published_at < Time.now
  end
  
  def summary_as_html
    rendered_summary.to_s.html_safe
  end
  
  def content_as_html
    rendered_content.to_s.html_safe
  end
  
  protected
  
  def render_sections
    ContentRenderer.new(self, :content).render if rendered_content.blank? || format_changed? || content_changed?
    ContentRenderer.new(self, :summary).render if rendered_summary.blank? || format_changed? || summary_changed?
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

