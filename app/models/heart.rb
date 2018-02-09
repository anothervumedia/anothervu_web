class Heart < ApplicationRecord
  belongs_to :project, counter_cache: true
  belongs_to :user

  validates :project, uniqueness: { scope: :user }
end
