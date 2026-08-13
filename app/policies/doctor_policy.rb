class DoctorPolicy < ApplicationPolicy



  def show?
    true
  end

  def create?
    user.admin? || user.hospital_owner?
  end

  def update?
    user.admin? || record.hospital.user_id == user.id
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

      elsif user.hospital_owner?
        # hospital owner can see doctors in their hospital
        scope.joins(:hospital).where(hospitals: { user_id: user.id })

      elsif user.doctor?
        # doctor can only see himself
        scope.where(id: user.id)

      else
        scope.none
      end
    end
  end

end