class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    redirect_to root_path, :flash => { :error => 'Something went terribly wrong and your message can not be sent...' }
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      #flash.now[:error] = nil
      #flash.now[:notice] =
      redirect_to root_path, :flash => { :notice => 'Cool! Message is in cyberspace. We will get back to you ASAP.' }
    else
      new
    end
  end
end