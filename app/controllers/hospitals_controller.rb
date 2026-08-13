class HospitalsController < ApplicationController
  before_action :authenticate_user_or_doctor!

  def index
    if user_signed_in?
      hospital = current_user.hospitals.first
      if hospital.present?
        redirect_to hospital_path(hospital)
      else
        redirect_to new_hospital_path
      end
    elsif doctor_signed_in?
      redirect_to hospital_path(current_doctor.hospital, mode: "doctor_table")
    else
      redirect_to new_user_session_path
    end
  end

 def show
 @hospital = Hospital.find(params[:id])
  authorize @hospital
  @mode = params[:mode] || "hospital_details"
  @doctor = Doctor.new
  @patient = Patient.new

  if params[:mode] == "appointment_table"
    @appointments = @hospital.appointments.includes(:doctor, :patient).order(scheduled_at: :desc)
  end

  if params[:mode] == "appointment_form"
    @appointment = @hospital.appointments.new
  end

  if params[:mode] == "appointment_edit" && params[:appointment_id].present?
  @edit_appointment = true
  @appointment = @hospital.appointments.find_by(id: params[:appointment_id])
end

  if params[:mode] == "appointment_show" && params[:appointment_id].present?
    @appointment = @hospital.appointments.includes(:doctor, :patient).find_by(id: params[:appointment_id])
  end

  if params[:edit_doctor].present?
    @edit_doctor = true
    @doctor = @hospital.doctors.find(params[:edit_doctor])
  end

  if params[:doctor_id].present? && params[:mode] == "doctor_show"
    @doctor = @hospital.doctors.find_by(id: params[:doctor_id])
  end

  if params[:patient_id].present? && params[:mode] == "patient_show"
    @patient = @hospital.patients.find_by(id: params[:patient_id])
  end

  if params[:patient_id].present? && params[:mode] == "patient_edit"
    @edit_patient = true
    @patient = @hospital.patients.find_by(id: params[:patient_id])
  end
end

  def new
    @hospital = Hospital.new
  end

  def create
    @hospital = current_user.hospitals.build(hospital_params)

    if @hospital.save
      redirect_to hospitals_path, notice: "Hospital created"
    else
      render :new
    end
  end
def upload_image
  @hospital = Hospital.find(params[:id])

  if params[:hospital].present? && params[:hospital][:image].present?
    @hospital.image.attach(params[:hospital][:image])
    flash[:notice] = "Image uploaded successfully"
  else
    flash[:alert] = "Please select an image first"
  end

  redirect_to hospital_path(@hospital)
end
  def destroy
    @hospital = current_user.hospitals.find(params[:id])
    @hospital.destroy
    redirect_to hospitals_path
  end
 def remove_image
  @hospital = Hospital.find(params[:id])
  @hospital.image.purge

  redirect_to hospital_path(@hospital), notice: "Image removed successfully"
end
  private

def hospital_params
  params.require(:hospital).permit(:name, :email, :phone, :city, :image)
end
end