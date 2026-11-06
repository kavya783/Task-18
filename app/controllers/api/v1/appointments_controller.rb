class Api::V1::AppointmentsController < Api::BaseController

  def index
    render json: Hospital.find(params[:hospital_id]).appointments
  end

  def show
    render json: Appointment.find(params[:id])
  end

  def create
  hospital = Hospital.find(params[:hospital_id])

  appointment = hospital.appointments.new(appointment_params)

  if appointment.save
    render json: appointment, status: :created
  else
    render json: { errors: appointment.errors.full_messages }, status: :unprocessable_entity
  end
end

  def doctor_appointments
  if current_doctor
    render json: current_doctor.appointments
  else
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end 
  def patient_appointments
        render json: current_patient.appointments
      end

  private

  def appointment_params
  params.require(:appointment).permit(
    :doctor_id,
    :patient_id,
    :scheduled_at,
    :status,
    :reason,
    :appointment_type,
    :token_number,
    :doctor_notes
  )
end
end