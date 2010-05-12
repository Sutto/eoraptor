class CachingObserver < ActiveRecord::Observer
  
  observe :post, :page, :project
  
  def after_save(record)
    Rails.logger.warn "CachingObserver called w/ record: #{record.inspect}"
    CacheManager.expire_record record
  end
  
end
