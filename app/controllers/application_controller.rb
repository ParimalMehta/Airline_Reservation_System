class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :authorized
  helper_method :logged_in?
  helper_method :forgery
  helper_method :forgery_feedback
  helper_method :forgery_flight
  helper_method :forgery_reservation

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authenticate_user!
    redirect_to 'login' unless current_user
  end

  def logged_in?
    !current_user.nil?
  end
  def authorized
    redirect_to root_path unless logged_in?
  end

  def forgery
    if current_user.admin == true

    elsif @user != current_user
      redirect_to '/', notice: "You are not authorized to access this information. Please login."
    end
  end

  def forgery_feedback
    if current_user.admin == true

    elsif @feedback.user_id != current_user.id
      redirect_to '/', notice: "You are not authorized to access this information. Please login."
    end
  end
  def forgery_reservation
    if current_user.admin == true

    elsif @reservation.user_id != current_user.id
      redirect_to '/', notice: "You are not authorized to access this information. Please login."
    end
  end
  def forgery_flight
    if current_user.admin == true

    elsif @flight.user_id != current_user.id
      redirect_to '/', notice: "You are not authorized to access this information. Please login."
    end
  end
  
  


end
