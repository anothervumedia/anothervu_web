class Project < ApplicationRecord
  belongs_to :user
  has_many :uploads, dependent: :destroy
  has_many :hearts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  accepts_nested_attributes_for :uploads, allow_destroy: true

  paginates_per 12

  scope :with_upload, -> { joins(:uploads).group('projects.id') }

end
