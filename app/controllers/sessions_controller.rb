
class SessionsController < ApplicationController

  def new
    render "devise/sessions/new"
  end

  def create
    email = params[:email]
    password = params[:password]

    # First check User (Devise)
   user = User.find_by(email: email)

Rails.logger.info "USER FOUND: #{user.present?}"
Rails.logger.info "USER PASSWORD VALID: #{user&.valid_password?(password)}"
Rails.logger.info "HOSPITAL FOUND: #{user&.hospitals&.exists?}"

    if user&.valid_password?(password)
      sign_in(user)

      hospital = user.hospitals.first

      if hospital.present?
        redirect_to hospital_path(hospital, mode: "hospital_details")
      else
        redirect_to new_session_path
      end
      return
    end

    # Check Hospital
    hospital = Hospital.find_by(email: email)

    if hospital&.authenticate(password)
      session[:hospital_id] = hospital.id
      redirect_to hospital_path(hospital)
      return
    end

    # Check Doctor
    doctor = Doctor.find_by(email: email)

    if doctor&.authenticate(password)
      session[:doctor_id] = doctor.id
      redirect_to doctor_dashboard_path(doctor)
      return
    end

    # Check Patient
    patient = Patient.find_by(email: email)

    if patient&.authenticate(password)
      session[:patient_id] = patient.id
      redirect_to patient_dashboard_path(patient)
      return
    end

    invalid_login
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: "Logged out successfully."
  end

  def destroy_patient
    session.delete(:patient_id)
    redirect_to "/patient_sign_in",
                notice: "Patient logged out successfully."
  end

  private

  def invalid_login
    @error_message = "Invalid email or password"

    render "devise/sessions/new",
           status: :unprocessable_entity
  end

end
