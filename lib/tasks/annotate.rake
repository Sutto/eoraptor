namespace :db do
  task :annotate do
    Annotate::Migration.update_annotations
  end
end

module Annotate
  class Migration
    @@working = false

    def self.update_annotations
      unless @@working
        @@working = true
        Rake::Task['annotate_models'].invoke
      end
    end
  end
end