class FlightsController < ApplicationController
  before_action :set_flight, only: %i[ show edit update destroy ]
  before_action :forgery_flight, only: %i[ show edit update destroy ]


  $five = "abc"
  # GET /flights or /flights.json
  def index
      @flights = Flight.all    
  end

  # GET /flights/1 or /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @airport = Airport.all.map{ |u| [ u.airport_place ] }
    @flight = Flight.new
  end

  def bookaflight
      @flights = Flight.all
      
      @origin = @flights.map{ |u| [ u.origin_airport ] }.uniq
      @destination = @flights.map{ |u| [ u.destination_airport ] }.uniq
       @departure_dates = @flights.map{ |u|  u.departure_date unless u.departure_date < ( Date.today + 1.day )  }.uniq
      # @departure_dates = @flights.map{ |u|  u.departure_date   }.uniq

      @flight_number = "C0kEoBXcL5&g@W$2HC3k"
      @flight_capacity = 56
      @flight_price = 10

      @flight = Flight.new 
      
  end

  def passbookaflight
   @flights = $five
  end

  # GET /flights/1/edit
  def edit
    @airport = Airport.all.map{ |u| [ u.airport_place ] }
  end

  # POST /flights or /flights.json
  def create
    @flight = Flight.new(flight_params)

    if(@flight.flight_number == "C0kEoBXcL5&g@W$2HC3k" )

      $five = Flight.all.select{ | flight | ( flight.origin_airport == @flight.origin_airport ) && ( flight.destination_airport == @flight.destination_airport ) && ( flight.departure_date == @flight.departure_date ) }
      respond_to do |format|
        if $five
          format.html { redirect_to '/passbookaflight', notice: "Flight search." }
          format.json { render :passbookaflight, status: :created, location: $five }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @flight.errors, status: :unprocessable_entity }
        end 
      end     
    else   

    respond_to do |format|
      if @flight.save
        format.html { redirect_to @flight, notice: "Flight was successfully created." }
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end      
    end
  end
  end

  # PATCH/PUT /flights/1 or /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to @flight, notice: "Flight was successfully updated." }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1 or /flights/1.json
  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to flights_url, notice: "Flight was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flight_params
      params.require(:flight).permit(:flight_number, :origin_airport, :destination_airport, :departure_date, :departure_time, :flight_capacity, :flight_price)
    end  

  
end
