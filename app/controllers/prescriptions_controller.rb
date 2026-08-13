class PrescriptionsController < ApplicationController
  before_action :ensure_doctor_signed_in!
  before_action :set_prescription, only: [:update, :destroy]

  def create
    @prescription = Prescription.new(prescription_params)
    @prescription.doctor = current_doctor
    @prescription.appointment_id = params[:appointment_id]

    if @prescription.save
      redirect_to doctor_dashboard_path(current_doctor,
        mode: "prescription_table"),
        notice: "Prescription added successfully."
    else
      redirect_to doctor_dashboard_path(current_doctor,
        mode: "prescription_table"),
        alert: @prescription.errors.full_messages.to_sentence
    end
  end

  def update
  end

  def destroy
    @prescription.destroy

    redirect_to doctor_dashboard_path(current_doctor,
      mode: "prescription_table")
  end

  private

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

  def prescription_params
    params.require(:prescription)
          .permit(:prescription, :patient_id)
  end
end