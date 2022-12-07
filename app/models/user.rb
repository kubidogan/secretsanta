class User < ApplicationRecord
  has_many :invitations
  has_many :groups, through: :invitations
  has_one :wishlist
  has_many :gifts, through: :wishlist
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
