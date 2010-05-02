class Admin::PostsController < Admin::BaseController
  
  include PseudocephalopodResourceExt
  
  protected
  
  def end_of_association_chain
    super.ordered_with_unpublished_first
  end
  
end
