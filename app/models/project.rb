class Project < ApplicationRecord
  belongs_to :user
  has_many :uploads, dependent: :destroy
  has_many :hearts, dependent: :destroy

  accepts_nested_attributes_for :uploads, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true

  paginates_per 12
end
