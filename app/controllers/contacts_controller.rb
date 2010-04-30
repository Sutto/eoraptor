class ContactsController < ApplicationController
  
  def new
    @contact = ContactForm.new(params[:contact_form])
  end
  
  def create
    @contact = ContactForm.new(params[:contact_form])
    if @contact.valid?
      @contact.deliver
      redirect_to :root, :notice => "Thanks! your message has been sent and I'll get back to you as soon as possible"
    else
      render :action => "new"
    end
  end
  
end