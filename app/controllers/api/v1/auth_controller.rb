class Api::V1::AuthController < Api::BaseController
  skip_before_action :authenticate_user, only: [:login]

  def login
    user =
      Hospital.find_by(email: params[:email]) ||
      Doctor.find_by(email: params[:email]) ||
      Patient.find_by(email: params[:email])

    if user&.authenticate(params[:password])

      token = JsonWebToken.encode({
        user_id: user.id,
        role: user.class.name
      })

      render json: {
        message: "Login successful",
        role: user.class.name,
        token: token,
        user: user
      }
    else
      render json: {
        error: "Invalid email or password"
      }, status: :unauthorized
    end
  end
end