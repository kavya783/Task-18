class PatientsController < ApplicationController
  before_action :authenticate_patient!, only: [:dashboard]
  before_action :set_hospital, except: [:dashboard]
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = @hospital.patients
  end

  def new
    @patient = @hospital.patients.build
  end

  def create
    @patient = @hospital.patients.build(patient_params)

    if @patient.save
      redirect_to hospital_path(@hospital, mode: "patient_table"),
                  notice: "Patient created successfully"
    else
      @mode = "patient_form"
      render "hospitals/show", status: :unprocessable_entity
    end
  end

  def show
    redirect_to hospital_path(@hospital, mode: "patient_table")
  end

  def dashboard
    @patient = current_patient

    unless @patient
      redirect_to new_session_path, alert: "Please sign in as patient." and return
    end

    if params[:id].to_i != @patient.id
      redirect_to patient_dashboard_path(@patient) and return
    end

    @mode = params[:mode].presence || "dashboard"
    @appointments = @patient.appointments.includes(:doctor)
    @prescriptions = @patient.prescriptions.includes(:doctor)
  end

  def edit
    @patient = @hospital.patients.find(params[:id])
    @mode = "patient_edit"
    @edit_patient = true
    render "hospitals/show"
  end

  def update
    if @patient.update(patient_params)
      redirect_to hospital_path(@hospital, mode: "patient_table"),
                  notice: "Patient updated successfully"
    else
      @mode = "patient_edit"
      @edit_patient = true
      render "hospitals/show", status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    redirect_to hospital_path(@hospital, mode: "patient_table"),
                notice: "Patient deleted successfully"
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:hospital_id])
  end

  def set_patient
    @patient = @hospital.patients.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:name, :email, :age, :disease, :phone,:password, :password_confirmation)
  end
end