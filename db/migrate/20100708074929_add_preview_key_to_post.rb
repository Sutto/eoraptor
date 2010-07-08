class AddPreviewKeyToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :preview_key, :string
  end

  def self.down
    remove_column :posts, :preview_key
  end
end
