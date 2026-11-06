class Api::V1::DoctorAuthController < Api::BaseController
  skip_before_action :authenticate_request, only: [:signup]

  def signup
    doctor = Doctor.new(doctor_params)

    if doctor.save
      token = JsonWebToken.encode({
        doctor_id: doctor.id,
        role: "Doctor"
      })

      render json: {
        doctor: doctor.as_json(except: [:password_digest]),
        token: token
      }, status: :created
    else
      render json: {
        errors: doctor.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(
      :name, :email, :password, :specialization,
      :hospital_id, :qualification, :city, :phone
    )
  end
end