class Flight < ApplicationRecord
  has_many :transactions, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy
end
