class DoctorMailer < ApplicationMailer
  def new_appointment(appointment)
    @appointment = appointment
    @doctor = appointment.doctor

    mail(
      to: @doctor.email,
      subject: "New Appointment Received"
    )
  end
end