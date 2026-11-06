class Api::V1::HospitalAuthController < ApplicationController
  skip_before_action :authenticate_user, only: [:signup]

  def signup
    hospital = Hospital.new(hospital_params)

    if hospital.save
      token = JsonWebToken.encode({
        hospital_id: hospital.id,
        role: "Hospital"
      })

      render json: { hospital: hospital, token: token }, status: :created
    else
      render json: { errors: hospital.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def hospital_params
    params.require(:hospital).permit(:name, :email, :phone, :city, :password)
  end
end