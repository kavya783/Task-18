  class AppointmentsController < ApplicationController
    before_action :authenticate_user_or_doctor!
    before_action :set_hospital
    before_action :set_appointment, only: [:update, :destroy, :update_status]
    

    def create
      @appointment = @hospital.appointments.new(appointment_params)
      @appointment.status = "Pending"
      authorize @appointment
      if @appointment.save

        PatientMailer.appointment_notification(@appointment, "Confirmed").deliver_later
        DoctorMailer.new_appointment(@appointment).deliver_later

        redirect_to hospital_path(@hospital, mode: "appointment_table"),
                    notice: "Appointment created successfully"
      else
        @mode = "appointment_form"
        render "hospitals/show", status: :unprocessable_entity
      end
    end


    def update
      if @appointment.update(appointment_params)

        PatientMailer.appointment_notification(@appointment, "Updated").deliver_later

        redirect_to hospital_path(@hospital, mode: "appointment_table"),
                    notice: "Appointment updated successfully"
      else
        @mode = "appointment_edit"
        render "hospitals/show", status: :unprocessable_entity
      end
    end

def update_status
  authorize @appointment

  allowed_status = ["Pending", "Conformed", "Cancelled", "Completed"]

  unless allowed_status.include?(params[:status])
    redirect_back fallback_location: root_path,
                  alert: "Invalid appointment status."
    return
  end

  if @appointment.update(status: params[:status])

    PatientMailer
      .appointment_notification(@appointment, params[:status])
      .deliver_later

    if doctor_signed_in?
      redirect_to doctor_dashboard_path(
        current_doctor,
        mode: "appointment_table"
      ), notice: "Appointment status updated successfully."
    else
      redirect_to hospital_path(
        @hospital,
        mode: "appointment_table"
      ), notice: "Appointment status updated successfully."
    end

  else
    redirect_back fallback_location: root_path,
                  alert: @appointment.errors.full_messages.to_sentence
  end
end
  def show
    @appointment = Appointment.find(params[:id])
    authorize @appointment
  end

    def destroy

      PatientMailer.appointment_notification(@appointment, "Cancelled").deliver_later

      @appointment.destroy

      redirect_to hospital_path(@hospital, mode: "appointment_table"),
                  notice: "Appointment deleted."
    end

    private

    def set_hospital
      @hospital = Hospital.find(params[:hospital_id])
    end

    def set_appointment
      @appointment = @hospital.appointments.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(
        :doctor_id,
        :patient_id,
        :scheduled_at,
        :reason,
        :appointment_type,
        :token_number
      )
    end
  end