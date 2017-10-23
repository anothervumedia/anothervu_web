class Upload < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader

  belongs_to :project

  before_destroy :delete_cloudinary_asset

  def delete_cloudinary_asset
    if self.image?
      Cloudinary::Uploader.destroy(image.my_public_id)
    elsif self.video?
      Cloudinary::Uploader.destroy(video.my_public_id)
    end
  end
end
