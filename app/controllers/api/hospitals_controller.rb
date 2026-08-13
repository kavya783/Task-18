class Api::HospitalsController < Api::BaseController
  def index
  hospitals = @current_user.hospitals

  render json: hospitals.as_json(
    except: [:password_digest]
  )
end
end