class AddCachedSlugToProjects < ActiveRecord::Migration
  
  def self.up
    add_column :projects, :cached_slug, :string
    add_index  :projects, :cached_slug
  end

  def self.down
    remove_column :projects, :cached_slug
  end
  
end
