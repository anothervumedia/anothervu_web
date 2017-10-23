class Project < ApplicationRecord
  belongs_to :user
  has_many :uploads
  has_many :hearts

  validates :name, presence: true
  validates :description, presence: true

  paginates_per 12
end
