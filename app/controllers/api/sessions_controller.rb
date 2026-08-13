class Api::SessionsController < Api::BaseController
  skip_before_action :authenticate_request

  def create
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      token = JWT.encode(
        { user_id: user.id },
        Rails.application.secret_key_base,
        "HS256"
      )

      render json: { token: token }
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end
end