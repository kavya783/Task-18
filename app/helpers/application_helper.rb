module ApplicationHelper
  def current_sidebar_mode
    params[:mode].presence || @mode.to_s.presence || "hospital_details"
  end

  def sidebar_section(mode)
    case mode.to_s
    when "", "hospital_details"
      "hospital_details"
    when /^doctor_/, "doctor_table"
      "doctor_table"
    when /^patient_/, "patient_table"
      "patient_table"
    when /^appointment_/, "appointment_table"
      "appointment_table"
    else
      mode.to_s
    end
  end

  def sidebar_active_class(target_section)
    current_section = sidebar_section(current_sidebar_mode)
    "nav-link text-white #{'active bg-primary' if current_section == target_section}"
  end

  def doctor_sidebar_active_class(target_mode)
    current_mode = params[:mode].presence || ""
    "nav-link text-white #{'active bg-primary' if current_mode == target_mode}"
  end

  def patient_sidebar_active_class(target_mode)
    current_mode = params[:mode].presence || "dashboard"
    "nav-link text-white #{'active bg-primary' if current_mode == target_mode}"
  end
end
