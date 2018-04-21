class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :smart_add_url_protocol, on: :update

  has_many :projects, dependent: :destroy
  has_many :hearts, dependent: :destroy
  has_many :comments, dependent: :destroy

  protected

    def smart_add_url_protocol
      if self.website.present?
        unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
          self.website = "http://#{self.website}"
        end
      end
    end

    def confirmation_required?
      false
    end
end
