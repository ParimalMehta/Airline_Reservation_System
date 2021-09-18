class User < ApplicationRecord
  has_secure_password

  has_many :transactions, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy

  validates :name_on_card,presence: true
  validates :address,presence: true
  validates :expiration_date, presence: true
  validates :phone_number,presence: true, length: { is: 10 }
  validates :card_number,presence: true, length: { is: 16 }
  validates :cvv,presence: true, length: { is: 3 }
  validates :email, presence: true, uniqueness: true
end
