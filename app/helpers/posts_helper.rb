module PostsHelper
  
  def summary_with_full_link(post)
    html = first_paragraph_of post.summary_as_html
    link = link_to "Continue Reading &raquo;".html_safe, post_path(post), :class => 'view-more'
    html.gsub(/(\.|\!|\?)?\s*<\/p>/) { "#{$1 || "."} #{link}</p>" }.html_safe
  end
  
  def pagination_links_for(collection)
    inner = []
    inner << link_to_page(collection.next_page,     '&laquo; View Older Posts', :class => 'older-posts')
    inner << link_to_page(collection.previous_page, 'View Newer Posts &raquo;', :class => 'newer-posts')
    content_tag(:div, inner.sum(ActiveSupport::SafeBuffer.new), :class => 'pagination')
  end
  
  def in_year_order(posts)
    collections = ActiveSupport::OrderedHash.new([])
    years = posts.map { |p| p.published_at.year }.uniq.sort.reverse
    years.each do |year|
      yield year, posts.select { |p| p.published_at.year == year } if block_given?
    end
  end
  
  def in_month_order(posts)
    months = posts.map { |p| p.published_at.month }.uniq.sort.reverse
    months.each do |month|
      ordered_posts = posts.select { |p| p.published_at.month == month }.sort_by(&:published_at)
      yield Time.utc(Time.now.year, month).strftime("%B"), ordered_posts if block_given?
    end
  end
  
  protected
  
  def link_to_page(page, text, options = {})
    if page.nil?
      content_tag :span, text.html_safe, options
    else
      link_to text.html_safe, {:page => page}, options
    end
  end
  
end
