class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :forgery, only: %i[ show edit update destroy ]


  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/', notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @r1 = Reservation.all 
    @r2 = @r1.select{ | r | r.user_id = @user.id }
    @f1 = Flight.all 
    @r2.each { | x | 
      @f1.each { | f |  
        if f.id == x.flight_id
          f.flight_capacity = f.flight_capacity.to_i + x.number_of_seats.to_i
          f.save
        
        end}
    }
    
    
    if current_user.admin == true
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      #@u = @user.id
      @user.destroy
      session[:user_id] = nil
      redirect_to root_url, notice: 'Logged out!'
      #session[current_user.id] = nil   
     # session.destroy 
      #redirect_to root_url, notice: 'User destroyed!'
      # @uk = User.find_by_id(@u)
      # @uk.destroy      
      
      
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone_number, :address, :name_on_card, :card_number, :expiration_date, :cvv, false)
    end
end
