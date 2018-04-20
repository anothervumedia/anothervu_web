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
    where("lower(projects.name) LIKE ? OR lower(projects.description) LIKE ? OR lower(projects.location) LIKE ? OR lower(projects.category) LIKE ? OR lower(projects.designer) LIKE ?", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%")
  end

end
