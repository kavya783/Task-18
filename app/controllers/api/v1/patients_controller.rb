class Api::V1::PatientsController < Api::BaseController

  def index
    hospital = Hospital.find_by(id: params[:hospital_id])

    if hospital
      render json: hospital.patients
    else
      render json: { error: "Hospital not found" }, status: :not_found
    end
  end

  def create
    hospital = Hospital.find_by(id: params[:hospital_id])

    return render json: { error: "Hospital not found" }, status: :not_found unless hospital

    patient = hospital.patients.new(patient_params)

    if patient.save
      render json: patient, status: :created
    else
      render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def my_patients
  return render json: { error: "Unauthorized" }, status: :unauthorized unless current_doctor

  render json: current_doctor.patients
end
def my_doctor
  return render json: { error: "Unauthorized" }, status: :unauthorized unless current_patient

  render json: current_patient.doctor
end
def destroy
  hospital = Hospital.find(params[:hospital_id])
  patient = hospital.patients.find(params[:id])

  patient.destroy

  render json: { message: "Patient deleted successfully" }
end
  private

  def patient_params
    params.require(:patient).permit(
      :name,
      :age,
      :disease,
      :phone,
      :email,
      :password
    )
  end
end