
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_a?(User)
      can :manage, Hospital
      can :manage, Doctor
      can :manage, Patient
      can :manage, Appointment

    elsif user.is_a?(Hospital)
      can :manage, Doctor, hospital_id: user.id
      can :manage, Patient, hospital_id: user.id
      can :manage, Appointment, hospital_id: user.id
      can :read, Hospital, id: user.id
      can :update, Hospital, id: user.id

    elsif user.is_a?(Doctor)
      can :read, Patient
      can :read, Appointment
      can :update, Appointment
      can :read, Prescription
      can :create, Prescription

    elsif user.is_a?(Patient)
      can :read, Appointment
      can :create, Appointment
      can :read, Prescription
    end
  end
end
