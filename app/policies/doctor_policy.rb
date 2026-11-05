class DoctorPolicy < ApplicationPolicy

  def show?
    return false unless user.present?

    if user.is_a?(Hospital)
      record.hospital_id == user.id
    elsif user.is_a?(Doctor)
      record.id == user.id
    elsif user.is_a?(User)
      user.admin? || record.hospital&.user_id == user.id
    else
      false
    end
  end

  def create?
    user.is_a?(Hospital) ||
      (user.is_a?(User) && (user.admin? || user.hospital_owner?))
  end

  def update?
    return false unless user.present?

    if user.is_a?(Hospital)
      record.hospital_id == user.id
    elsif user.is_a?(User)
      user.admin? || record.hospital&.user_id == user.id
    else
      false
    end
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      if user.is_a?(Hospital)
        scope.where(hospital_id: user.id)
      elsif user.is_a?(Doctor)
        scope.where(id: user.id)
      elsif user.is_a?(User)
        if user.admin?
          scope.all
        else
          scope.joins(:hospital)
               .where(hospitals: { user_id: user.id })
        end
      else
        scope.none
      end
    end
  end
end