class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string   :title
      t.string   :cached_slug
      t.string   :state
      t.datetime :published_at
      t.string   :format
      t.text     :summary
      t.text     :rendered_summary
      t.text     :content
      t.text     :rendered_content
      t.timestamps
    end
    
    add_index :posts, :cached_slug
    add_index :posts, [:cached_slug, :published_at]
    
  end

  def self.down
    drop_table :posts
  end
end
