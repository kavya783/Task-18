class Api::V1::PatientAuthController < Api::BaseController
  skip_before_action :authenticate_user, only: [:signup]

  def signup
  patient = Patient.new(patient_params)

  if patient.save
    token = JsonWebToken.encode({
      patient_id: patient.id,
      role: "Patient"
    })

    render json: { patient: patient, token: token }, status: :created
  else
    render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
  end
end

  private

 def patient_params
  params.permit(:name, :email, :password, :age, :phone, :city, :doctor_id, :hospital_id, :disease)
end
end