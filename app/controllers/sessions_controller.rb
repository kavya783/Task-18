class SessionsController < ApplicationController
  def new
    render "devise/sessions/new"
  end

  def create
    email = params[:email]
    password = params[:password]

    if user = User.find_by(email: email)
     if user.valid_password?(password)
  sign_in(user)

  hospital = user.hospitals.first

  if hospital
    redirect_to hospital_path(hospital)
  else
    redirect_to new_session_path, alert: "No hospital assigned to this user"
  end

else
  @error_message = "Invalid email or password"
  render "devise/sessions/new", status: :unprocessable_entity
end

    elsif doctor = Doctor.find_by(email: email)
      if doctor.authenticate(password)
        session[:doctor_id] = doctor.id
        redirect_to doctor_dashboard_path(doctor)
      else
        @error_message = "Invalid email or password"
render "devise/sessions/new", status: :unprocessable_entity
      end

    elsif patient = Patient.find_by(email: email)
      if patient.authenticate(password)
        session[:patient_id] = patient.id
        redirect_to patient_dashboard_path(patient)
      else
        @error_message = "Invalid email or password"
render "devise/sessions/new", status: :unprocessable_entity
      end
    else
      @error_message = "Invalid email or password"
render "devise/sessions/new", status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:doctor_id)
    redirect_to new_session_path, notice: "Logged out successfully."
  end

  def destroy_patient
    session.delete(:patient_id)
    redirect_to new_session_path, notice: "Logged out successfully."
  end
end