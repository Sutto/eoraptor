class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string   :name
      t.text     :description
      t.text     :rendered_description
      t.string   :github_user
      t.string   :github_repository
      t.string   :website
      t.datetime :published_at
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
