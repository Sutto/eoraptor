ControllerExt.for(:translation) do
  
  protected
  
  helper_method :tf, :tu
  
  def tf(key)
    I18n.t(key.to_sym, :scope => :flash)
  end
  
  def tu(name, options = {})
    scope = [:ui, options.delete(:scope)].compact.join(".").to_sym
    I18n.t(name, options.merge(:scope => scope))
  end
  
end