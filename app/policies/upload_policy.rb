class UploadPolicy < ApplicationPolicy
  def create?
    user == record.project.user
  end

  def destroy?
    user == record.project.user
  end
end
