class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  before_action :forgery, only: %i[ show edit update destroy ]

  def index
  end
end
