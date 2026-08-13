class HospitalPolicy < ApplicationPolicy


  def show?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || record.user_id == user.id
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end

 

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.doctor?
        scope.where(doctor_id: user.id)
      else
        scope.none
      end
    end
  end

end