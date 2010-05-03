class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.text :rendered_content
      t.datetime :published_at
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
