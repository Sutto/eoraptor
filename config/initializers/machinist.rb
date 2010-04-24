if Rails.env.test? || ENV['MACHINIST']
  require 'machinist'
  require 'machinist/active_record'
  
  def Machinist.clear!
    Sham.clear
    ActiveRecord::Base.clear_blueprints!
  end
  
  def Machinist.load_blueprints
    Dir[Rails.root.join("test/blueprints", "**", "*.rb")].each do |file|
      load file
    end
  end
end