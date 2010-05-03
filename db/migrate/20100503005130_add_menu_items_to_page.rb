class AddMenuItemsToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :in_menu, :boolean
    add_column :pages, :position, :integer
  end

  def self.down
    remove_column :pages, :position
    remove_column :pages, :in_menu
  end
end
