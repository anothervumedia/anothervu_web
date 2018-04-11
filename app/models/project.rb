class Project < ApplicationRecord


  belongs_to :user
  has_many :uploads, dependent: :destroy
  has_many :hearts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  accepts_nested_attributes_for :uploads, allow_destroy: true

  paginates_per 12

  scope :with_upload, -> { joins(:uploads).group('projects.id') }

  def self.search(search)
    where("projects.name LIKE ? OR projects.description LIKE ? OR projects.location LIKE ? OR projects.category LIKE ? OR projects.designer LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end

end
