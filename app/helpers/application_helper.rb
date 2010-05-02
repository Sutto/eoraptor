module ApplicationHelper
  
  def flash_messages(*names)
    names = names.select { |k| flash[k].present? }
    return if names.blank?
    content = []
    names.each_with_index do |key, idx|
      value = flash[key]
      first, last = (idx == 0), (idx == names.length - 1)
      content << content_tag(:p, value, :class => "flash #{key} #{"first" if first} #{"last" if last}".strip)
    end
    content_tag(:section, content.sum(ActiveSupport::SafeBuffer.new), :id => "flash-messages").html_safe
  end
  
  def copyright(year, now=Time.now)
    if now.year == year
      year.to_s
    elsif year / 1000 == now.year / 1000 # same century
      year.to_s + "&ndash;" + now.year.to_s[-2..3]
    else
      year.to_s + "&ndash;" + now.year.to_s
    end
  end
  
  def menu_link(*args, &blk)
    content_tag(:li, link_to(*args, &blk), :class => 'menu-item')
  end
  alias ml menu_link
  
  def google_analytics
    if Settings.google_analytics.identifier?
      inner = javascript_include_tag("#{request.ssl? ? "https://ssl" : "http://www"}.google-analytics.com/ga.js")
      inner << javascript_tag(google_analytics_snippet_js(Settings.google_analytics.identifier))
    end
  end
  
  def google_analytics_snippet_js(identifier)
    "try { var pageTracker = _gat._getTracker(#{identifier.to_json}); pageTracker._trackPageview(); } catch(e) {}"
  end
  
  def first_paragraph_of(text)
    Nokogiri::HTML(text).at('p').try(:to_html).try(:html_safe) || text
  end
  
  def meta_tag(name, content)
    tag(:meta, :name => name.to_s, :content => content.to_s)
  end
  
  def formatted_published_time(object)
    object.published_at.blank? ? "Not yet published" : l(object.published_at, :format => :long)
  end
  
end
