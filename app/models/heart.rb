class Heart < ApplicationRecord
  belongs_to :upload, counter_cache: true
  belongs_to :user

  validates :upload, uniqueness: { scope: :user }
end
