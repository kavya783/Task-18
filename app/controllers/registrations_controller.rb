class RegistrationsController < Devise::RegistrationsController

 def create
  build_resource(sign_up_params)

  begin
    resource.save!

    Rails.logger.info "USER CREATED: #{resource.id}"

    sign_in(resource)
    redirect_to new_session_path

  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "RECORD INVALID: #{e.message}"
    Rails.logger.error "ERRORS: #{e.record.errors.full_messages.inspect}"

    clean_up_passwords resource
    set_minimum_password_length
    render :new, status: :unprocessable_entity

  rescue StandardError => e
    Rails.logger.error "SIGNUP EXCEPTION: #{e.class} - #{e.message}"
    raise
  end
end

end