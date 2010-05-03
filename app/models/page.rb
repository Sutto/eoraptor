class Page < ActiveRecord::Base
  
  validates_presence_of :title, :content
  
  is_publishable
  is_convertable :content
  is_sluggable   :title
  
  scope :ordered_for_menu, published.where('in_menu = ?', true).order('position ASC').select('title, cached_slug')
  
  before_save :assign_default_position
  
  def self.update_order(id_array = nil)
    ids = Array(id_array).map { |i| i.to_i }.uniq
    update_all ["position = FIND_IN_SET(id, '?')", ids], ['id IN (?) AND in_menu = ?', ids, true]
  end
  
  def self.max_position_in_menu
    where('in_menu = ?', true).maximum(:position).to_i
  end
  
  protected
  
  def assign_default_position
    self.position = self.class.max_position_in_menu + 1 if in_menu? && position.blank?
  end

end

# == Schema Information
#
# Table name: pages
#
#  id               :integer         not null, primary key
#  title            :string(255)
#  content          :text
#  rendered_content :text
#  published_at     :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

