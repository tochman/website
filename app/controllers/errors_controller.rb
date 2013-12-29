class ErrorsController < ApplicationController
  def not_found
    #render :file => ::Rails.root.join('public','404.html'), :status => 404
    #render 'errors/404'
    respond_to do |format|
      format.html { render template: 'errors/404', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end

  end

  def server_error
    #render :status => 500, :formats => [:html]
    respond_to do |format|
      format.html { render template: 'errors/server_error', layout: 'layouts/application', status: 500 }
      format.all  { render nothing: true, status: 500 }
    end
  end

  def the_exception
    @e ||= env["action_dispatch.exception"]
  end

end

