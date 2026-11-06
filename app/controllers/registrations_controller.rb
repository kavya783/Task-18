class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource.save

    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_in(resource)
        redirect_to new_session_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        redirect_to new_session_path
      end
  else
  Rails.logger.error "SIGNUP ERRORS: #{resource.errors.full_messages}"

  clean_up_passwords resource
  set_minimum_password_length
  render :new, status: :unprocessable_entity
end
  end

end