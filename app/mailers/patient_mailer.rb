class PatientMailer < ApplicationMailer

  def appointment_notification(appointment, status_message)
    @appointment = appointment
    @patient = appointment.patient
    @status_message = status_message

    mail(
      to: @patient.email,
      subject: "Appointment #{status_message}"
    )
  end

end