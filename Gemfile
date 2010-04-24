source 'http://rubygems.org'

git "git://github.com/mislav/will_paginate.git", :ref => "rails3"

# General WIP Fixes.
git "git://github.com/Sutto/exception_notification.git"
git "git://github.com/Sutto/validation_reflection.git"
git "git://github.com/justinfrench/formtastic.git", :ref => "rails3"
git "git://github.com/railsjedi/jammit.git"


# Start gems
gem 'rails', '3.0.0.beta3'
gem "rails3-generators"

gem "haml"
gem "forgery", ">= 0.3.4"

gem 'unicorn'

gem "formtastic", "= 0.9.8"
gem "validation_reflection"

gem "compass", ">= 0.10.0.rc1"
gem "compass-960-plugin"
gem "compass-colors"
gem "fancy-buttons"

gem "inherited_resources", ">= 1.1.2"
gem "responders",          ">= 0.6.0"
gem "show_for",            ">= 0.2.1"

gem "will_paginate",       ">= 3.0.pre"
gem "state_machine"
gem "title_estuary"

gem "mail_form"
gem "jammit"

gem "exception_notifier", :require => nil
gem "stringex"
gem "pseudocephalopod", ">= 0.2.1"
gem "sitemap_generator"

gem "annotate"

# Content conversions
gem "rdiscount"
gem "RedCloth"

gem "mysql", :group => :production
gem 'sqlite3-ruby', :require => 'sqlite3', :group => [:development, :test]

group :test do
  gem "machinist"
  gem "shoulda", ">= 3.0.pre", :require => nil, :git => "git://github.com/adamhunter/shoulda.git", :ref => 'rails3'
  gem "redgreen", :require => nil
end