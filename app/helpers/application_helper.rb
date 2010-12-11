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
      javascript_tag(google_analytics_snippet_js(Settings.google_analytics.identifier))
    end
  end
  
  def google_analytics_snippet_js(identifier)
    return <<-END_OF_JS
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', #{identifier.to_json}]);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
    END_OF_JS
  end
  
  def clicky_snippet_js(identifier)
    return <<-END_OF_JS
      var clicky = {log: function(){return;}, goal: function(){return;}};
      var clicky_site_id = #{identifier};
      (function() {
        var s   = document.createElement('script');
        s.type  = 'text/javascript';
        s.async = true;
        s.src   = (document.location.protocol + '//static.getclicky.com/js');
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(s);
      })();
    END_OF_JS
  end
  
  def clicky_noscript_tag(identifier)
    image_tag = tag(:img, :height => 1, :width => 1, :alt => 'Clicky Analytics', :src => "http://in.getclicky.com/#{identifier}n.gif")
    content_tag(:noscript, image_tag)
  end
  
  def clicky
    if Settings.clicky.site_id?
      site_id = Settings.clicky.site_id
      javascript_tag(clicky_snippet_js(site_id)) + clicky_noscript_tag(site_id)
    end
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
  
  def absolutize_links(html)
    doc = Nokogiri::HTML(html)
    doc.search('a').each do |link|
      href = link['href'].to_s
      link['href'] = "http://#{request.host}#{href}" if href =~ /^\//
    end
    doc.at('*').to_html.html_safe
  end
  
end
