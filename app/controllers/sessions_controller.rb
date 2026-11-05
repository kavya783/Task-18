class SessionsController < ApplicationController
  def new
    render "devise/sessions/new"
  end

  def create
    email = params[:email]
    password = params[:password]

    hospital = Hospital.find_by(email: email)

    if hospital&.authenticate(password)
      session[:hospital_id] = hospital.id
      redirect_to hospital_path(hospital)

    elsif doctor = Doctor.find_by(email: email)
      if doctor.authenticate(password)
        session[:doctor_id] = doctor.id
        redirect_to doctor_dashboard_path(doctor)
      else
        invalid_login
      end

    elsif patient = Patient.find_by(email: email)
      if patient.authenticate(password)
        session[:patient_id] = patient.id
        redirect_to patient_dashboard_path(patient)
      else
        invalid_login
      end

    else
      invalid_login
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path, notice: "Logged out successfully."
  end

  def destroy_patient
    session.delete(:patient_id)
    redirect_to patient_sign_in_path,
                notice: "Patient logged out successfully."
  end

  private

  def invalid_login
    @error_message = "Invalid email or password"
    render "devise/sessions/new",
           status: :unprocessable_entity
  end
end