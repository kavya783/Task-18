class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_a?(User)
      can :manage, Hospital
      can :manage, Doctor
      can :manage, Patient
      can :manage, Appointment

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