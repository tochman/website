class BookingsController < ApplicationController
  respond_to :html, :xml, :json
  
  before_action :find_subject

  def index
    @bookings = Booking.where("subject_id = ? AND end_time >= ?", @subject.id, Time.now).order(:start_time)
    respond_with @bookings
  end

  def new
    @booking = Booking.new(subject_id: @subject.id)
  end

  def create
    @booking =  Booking.new(params[:booking].permit(:subject_id, :start_time, :length))
    @booking.subject = @subject
    if @booking.save
      redirect_to subject_bookings_path(@subject, method: :get)
    else
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id]).destroy
    if @booking.destroy
      flash[:notice] = "Booking: #{@booking.start_time.strftime('%e %b %Y %H:%M%p')} to #{@booking.end_time.strftime('%e %b %Y %H:%M%p')} deleted"
      redirect_to subject_bookings_path(@subject)
    else
      render 'index'
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    # @booking.subject = @subject

    if @booking.update(params[:booking].permit(:subject_id, :start_time, :length))
      flash[:notice] = 'Your booking was updated succesfully'

      if request.xhr?
        render json: {status: :success}.to_json
      else
        redirect_to subject_bookings_path(@subject)
      end
    else
      render 'edit'
    end
  end

  private

  def save booking
    if @booking.save
        flash[:notice] = 'booking added'
        redirect_to subject_booking_path(@subject, @booking)
      else
        render 'new'
      end
  end

  def find_subject
    if params[:subject_id]
      @subject = Subject.find_by_id(params[:subject_id])
    end
  end

end
