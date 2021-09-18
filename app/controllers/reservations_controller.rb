class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]
  before_action :forgery_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @temp = params[:flight_id]
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @usr_id = params[:user_id]
    @flight = params[:flight_id]
    @user_dropdown = User.all.map{ |u| [ u.id ] }

    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
    @usr_id = @reservation.user_id
    @flight = @reservation.flight_id

  end

  # POST /reservations or /reservations.json
  def create
    $flag = false
    @reservation = Reservation.new(reservation_params)
    @flight = Flight.find_by_id(params[:reservation][:flight_id])
    @flight.flight_capacity =  (@flight.flight_capacity).to_i - (params[:reservation][:number_of_seats]).to_i
    if @flight.flight_capacity < 0
      @flight.flight_capacity =  (@flight.flight_capacity).to_i + (params[:reservation][:number_of_seats]).to_i
      redirect_to root_path, notice: "Number of selected seats not available. Reservation Failed"

    else

    @flight.save
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: "Reservation was successfully created. Confirmation email sent on registered email id." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end

      @f = Flight.find_by_id(@reservation.flight_id)
     
      Pony.mail(:to => current_user.email, :via => :smtp, :via_options =>{
        :address      => 'smtp.gmail.com',
        :port     => '587',
        :user_name     => '',
        :password => '',
        :enable_starttls_auto => true,
        :authentication      => :plain,           # :plain, :login, :cram_md5, no auth by default
        :domain   => "gmail.com"     # the HELO domain provided by the client to the server
      }, :from => 'airrailsairlines@gmail.com', 
        :subject => 'Confirmation: Your flight reservation has been booked with Air Rails Flight Booking Portal.', 
        :body => 'Hello '+ current_user.name + "\n" +' Your reservation has been created.' + "\n" + ' Details are' + "\n" + 'Flight Number :'+ @f.flight_number )
    end
  end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:confirmation_number, :flight_class, :number_of_seats, :user_id, :flight_id)
    end
end
