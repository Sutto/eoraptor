module ControllerExt
  
  def self.name_to_constant_key(name)
    :"#{name.to_s.classify}Ext"
  end
  
  def self.[](key)
    const_get name_to_constant_key(key) rescue nil
  end
  
  def self.for(name, &blk)
    key = name_to_constant_key(name)
    const_set key, Module.new unless const_defined?(key)
    const_get(key).tap do |m|
      m.module_eval(&blk) if blk.present?
    end
  end
  
  def uses_controller_extension(*args)
    args.each do |k|
      mod = ::ControllerExt[k]
      include mod if mod.present?
    end
  end
  
end