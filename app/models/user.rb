class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true, :on => [:create, :update_password]

  validates_presence_of :password_confirmation, require: true, :on => [:create, :update_password]

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  has_many :orders

  enum role: %w(default merchant admin)
end
