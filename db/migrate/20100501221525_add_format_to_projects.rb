class AddFormatToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :format, :string
  end

  def self.down
    remove_column :projects, :format
  end
end
