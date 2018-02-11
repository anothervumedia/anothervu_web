class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :hearts
<<<<<<< HEAD
=======

  protected

    def confirmation_required?
     false
    end
>>>>>>> a2f262fd63157918ebb3d9f88b78c1a170cf3c91
end
