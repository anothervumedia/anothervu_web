class Upload < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader

  validates :name, presence: true

  belongs_to :user
end
