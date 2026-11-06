class Api::V1::PrescriptionsController < Api::BaseController

  # Doctor creates prescription
  def create
    return render json: { error: "Unauthorized" }, status: :unauthorized unless current_doctor

    prescription = current_doctor.prescriptions.new(prescription_params)

    if prescription.save
      render json: prescription, status: :created
    else
      render json: { errors: prescription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Doctor view
 def doctor_prescriptions
    return render json: { error: "Unauthorized" }, status: :unauthorized unless current_doctor

    render json: current_doctor.prescriptions
  end

  # Patient view
  def patient_prescriptions
    return render json: { error: "Unauthorized" }, status: :unauthorized unless current_patient

    render json: current_patient.prescriptions
  end

  private

  def prescription_params
    params.require(:prescription).permit(:patient_id, :medicine_name, :notes)
  end
end