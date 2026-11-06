
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  helper_method :current_doctor, :doctor_signed_in?,
                :current_patient, :patient_signed_in?,
                :current_hospital, :hospital_signed_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to new_session_path,
                alert: "You are not authorized to perform this action."
  end

  private

  # Pundit authorization
  def pundit_user
    current_user || current_hospital || current_doctor || current_patient
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to new_session_path
  end

  # CanCanCan authorization
  def current_ability
    @current_ability ||= Ability.new(pundit_user)
  end

  # Redirect after User login
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      hospital = resource.hospitals.first

      if hospital.present?
        hospital_path(hospital, mode: "hospital_details")
      else
        new_session_path
      end
    else
      new_session_path
    end
  end
  # Redirect after User signup
def after_sign_up_path_for(resource)
  sign_in_path
end
  # Hospital login
  def current_hospital
    @current_hospital ||= Hospital.find_by(id: session[:hospital_id]) if session[:hospital_id]
  end

  def hospital_signed_in?
    current_hospital.present?
  end

  # Doctor login
  def current_doctor
    @current_doctor ||= Doctor.find_by(id: session[:doctor_id]) if session[:doctor_id]
  end

  def doctor_signed_in?
    current_doctor.present?
  end

  def ensure_doctor_signed_in!
    return if doctor_signed_in?

    redirect_to new_session_path, alert: "Please sign in as doctor."
  end

  # Patient login
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

  # Authentication for multiple roles
  def authenticate_user_or_doctor!
    return if user_signed_in? || hospital_signed_in? ||
              doctor_signed_in? || patient_signed_in?

    respond_to do |format|
      format.html do
        redirect_to new_session_path, alert: "Please sign in."
      end

      format.json do
        render json: { error: "Unauthorized" },
               status: :unauthorized
      end
    end
  end

  # Logout all roles
  def clear_all_sessions
    session.delete(:hospital_id)
    session.delete(:doctor_id)
    session.delete(:patient_id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:city, :phone, :hospital_name]
    )
  end
end
