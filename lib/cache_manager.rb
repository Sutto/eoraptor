class CacheManager
  class << self
    
    include Rails.application.routes.url_helpers
    
    def expire_record(record)
      STDOUT.puts "Expiring cache for #{record.inspect}"
      case record
      when Project
        expire_project record
      when Post
        expire_post record
      when Page
        expire_page record
      end
    end
    
    # Expired pages can change the menus on each page, so expire every url.
    def expire_page(page)
      expire_all
    end
    
    def expire_post(post)
      expire! post_path(post)
      expire! post_path(post.preview_key)
      expire! post_archives_path
      expire! post_rss_feed_path
      expire! full_post_rss_feed_path
      expire! root_path
    end
    
    def expire_project(project)
      expire! projects_path
      expire! project_path(project)
    end
    
    def expire_all
      Dir[Rails.root.join("public/**/*.{html,rss}")].each { |f| File.delete f }
    end
    
    protected
    
    def expire!(path)
      ApplicationController.expire_page path
    end
    
  end
end
