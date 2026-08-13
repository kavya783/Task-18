class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:dashboard, :patients]
   
def dashboard
  @doctor = Doctor.find(session[:doctor_id])
   @hospital = @doctor.hospital
  @mode = params[:mode]

  
  @patients = @doctor.patients
  @appointments = @doctor.appointments.includes(patient: :prescriptions)
  @prescriptions = @doctor.prescriptions

  if params[:mode] == "appointment_show" && params[:appointment_id].present?
    @appointment = @doctor.appointments.includes(:patient).find_by(id: params[:appointment_id])
    @patient_prescriptions = @appointment&.patient&.prescriptions || []
  end
end
  def patients
    @patients = @doctor.patients
  end 

  def index
    @hospital = Hospital.find(params[:hospital_id])
    @doctors = @hospital.doctors
  end

  def new
  @hospital = Hospital.find(params[:hospital_id])
  @doctor = @hospital.doctors.build

  authorize! :create, @doctor
end

def create
  @hospital = Hospital.find(params[:hospital_id])
  @doctor = @hospital.doctors.build(doctor_params)

  authorize! :create, @doctor

  if @doctor.save
    redirect_to hospital_path(@hospital, mode: "doctor_table"),
                notice: "Doctor created successfully"
  else
    @mode = "doctor_form"
    render "hospitals/show", status: :unprocessable_entity
  end
end
  def show
    @hospital = Hospital.find(params[:hospital_id])
    @doctor = @hospital.doctors.find(params[:id])
  end

 def edit
  @hospital = Hospital.find(params[:hospital_id])
  @doctor = @hospital.doctors.find(params[:id])
    authorize @doctor
  authorize! :update, @doctor
end

def update
  @hospital = Hospital.find(params[:hospital_id])
  @doctor = @hospital.doctors.find(params[:id])
   authorize @doctor
  authorize! :update, @doctor

  if @doctor.update(doctor_params)
    redirect_to hospital_path(@hospital, mode: "doctor_table"),
                notice: "Doctor updated successfully"
  else
    redirect_to hospital_path(@hospital, mode: "doctor_form", edit_doctor: @doctor.id),
                alert: @doctor.errors.full_messages.to_sentence
  end
end
 def destroy
  @hospital = Hospital.find(params[:hospital_id])
  @doctor = @hospital.doctors.find(params[:id])

  authorize! :destroy, @doctor

  @doctor.destroy

  redirect_to hospital_path(@hospital, mode: "doctor_table"),
              notice: "Doctor deleted successfully"
end
  private

  def set_doctor
    @doctor = if doctor_signed_in?
                current_doctor
              else
                Doctor.find(params[:id])
              end
  end

  def doctor_params
    permitted = params.require(:doctor).permit(
      :name, :qualification, :specialization, :city, :phone, :email, :password
    )

  if permitted[:password].blank?
    permitted.delete(:password)
  end

  permitted
end
end