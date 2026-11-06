class Api::V1::DoctorsController < Api::BaseController

  def index
    hospital = Hospital.find(params[:hospital_id])
    render json: hospital.doctors
  end

  def show
    hospital = Hospital.find(params[:hospital_id])
    doctor = hospital.doctors.find(params[:id])
    render json: doctor
  end

  def create
    hospital = Hospital.find(params[:hospital_id])
    doctor = hospital.doctors.new(doctor_params)

    if doctor.save
      render json: doctor, status: :created
    else
      render json: { errors: doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    hospital = Hospital.find(params[:hospital_id])
    doctor = hospital.doctors.find(params[:id])
    doctor.destroy
    render json: { message: "Doctor deleted" }
  end

  private

  def doctor_params
    params.require(:doctor).permit(
      :name,
      :qualification,
      :specialization,
      :city,
      :phone,
      :email,
      :password
    )
  end
end