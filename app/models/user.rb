class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :smart_add_url_protocol

  has_many :projects, dependent: :destroy
  has_many :hearts, dependent: :destroy


  protected

    def smart_add_url_protocol
      unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
        self.website = "http://#{self.website}"
      end
    end

    def confirmation_required?
     false
    end
end
