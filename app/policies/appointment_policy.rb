
class AppointmentPolicy < ApplicationPolicy

  def create?
    if user.is_a?(Hospital)
      record.hospital_id == user.id
    elsif user.is_a?(User)
      true
    elsif user.is_a?(Patient)
      record.patient_id == user.id
    else
      false
    end
  end

  def show?
    return false unless user.present?

    if user.is_a?(Hospital)
      record.hospital_id == user.id
    elsif user.is_a?(Doctor)
      record.doctor_id == user.id
    elsif user.is_a?(Patient)
      record.patient_id == user.id
    elsif user.is_a?(User)
      true
    else
      false
    end
  end

  def index?
    user.is_a?(User) ||
      user.is_a?(Hospital) ||
      user.is_a?(Doctor) ||
      user.is_a?(Patient)
  end

  def update?
    show?
  end
  def update_status?
  return false unless user.present?

  if user.is_a?(Hospital)
    record.hospital_id == user.id
  elsif user.is_a?(Doctor)
    record.doctor_id == user.id
  elsif user.is_a?(Patient)
    record.patient_id == user.id
  elsif user.is_a?(User)
    true
  else
    false
  end
end

  def destroy?
    if user.is_a?(Hospital)
      record.hospital_id == user.id
    elsif user.is_a?(User)
      true
    else
      false
    end
  end

  class Scope < Scope
    def resolve
      if user.is_a?(User)
        scope.all
      elsif user.is_a?(Hospital)
        scope.where(hospital_id: user.id)
      elsif user.is_a?(Doctor)
        scope.where(doctor_id: user.id)
      elsif user.is_a?(Patient)
        scope.where(patient_id: user.id)
      else
        scope.none
      end
    end
  end
end
