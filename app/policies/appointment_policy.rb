class AppointmentPolicy < ApplicationPolicy
  def create?
    user.is_a?(User) || user.is_a?(Patient)
  end

  def show?
    user.is_a?(User) || record.patient_id == user.id
  end

  def index?
    user.is_a?(User) || user.is_a?(Patient)
  end

  def update?
    user.is_a?(User) || record.patient_id == user.id
  end

  def destroy?
    user.is_a?(User) || record.patient_id == user.id
  end

  class Scope < Scope
    def resolve
      if user.is_a?(User)
        scope.all
      elsif user.is_a?(Patient)
        scope.where(patient_id: user.id)
      else
        scope.none
      end
    end
  end
end