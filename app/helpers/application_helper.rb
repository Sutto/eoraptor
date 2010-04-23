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
  
end
