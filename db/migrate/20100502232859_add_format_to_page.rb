class AddFormatToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :format, :string
  end

  def self.down
    remove_column :pages, :format
  end
end
