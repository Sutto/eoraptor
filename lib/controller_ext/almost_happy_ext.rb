ControllerExt.for(:almost_happy) do
  
  protected
  
  def end_of_association_chain
    super.ordered_for_preview
  end
  
end