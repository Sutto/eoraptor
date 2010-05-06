class CachingObserver < ActiveRecord::Observer
  
  observe :post, :page, :project
  
  def after_update(record)
    CacheManager.expire_record record
  end
  
end
