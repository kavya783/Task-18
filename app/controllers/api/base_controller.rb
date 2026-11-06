class Api::BaseController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers["Authorization"]
    token = header&.split(" ")&.last

    if token.blank?
      return render json: { error: "Unauthorized" }, status: :unauthorized
    end

    begin
      decoded_token = JWT.decode(
        token,
        Rails.application.secret_key_base,
        true,
        algorithm: "HS256"
      )

      @current_user = User.find(decoded_token[0]["user_id"])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
