class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_doctor, :doctor_signed_in?, :current_patient, :patient_signed_in?
    include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private

  def user_not_authorized
    flash[:alert] =  "You are not authorized to perform this action."
    redirect_to root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
  redirect_to new_session_path,
              alert: "You are not authorized to perform this action."
end
  def current_ability
  @current_ability ||= Ability.new(current_user || current_doctor || current_patient)
end
 def after_sign_in_path_for(resource)
  hospital = resource.hospitals.first

  if hospital&.persisted?
    hospital_path(hospital, mode: "hospital_details")
  else
    root_path
  end
end
  def current_patient
    @current_patient ||= Patient.find_by(id: session[:patient_id]) if session[:patient_id]
  end

  def patient_signed_in?
    current_patient.present?
  end

  def authenticate_patient!
    return if patient_signed_in?

    redirect_to new_session_path, alert: "Please sign in as patient."
  end
  def doctor_signed_in?
  current_doctor.present?
end

def ensure_doctor_signed_in!
  return if doctor_signed_in?

  redirect_to new_session_path,
              alert: "Please sign in as doctor."
end

def authenticate_user_or_doctor!
  return if user_signed_in? || doctor_signed_in?

  redirect_to new_session_path, alert: "Please sign in."
end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:city, :phone,  :hospital_name])
  end

  def current_doctor
    @current_doctor ||= Doctor.find_by(id: session[:doctor_id]) if session[:doctor_id]
  end

  def doctor_signed_in?
    current_doctor.present?
  end

  def authenticate_user_or_doctor!
    return if user_signed_in? || doctor_signed_in?

    redirect_to new_doctor_session_path, alert: "Please sign in."
  end
end