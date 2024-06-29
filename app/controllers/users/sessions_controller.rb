module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    def create
      user = User.find_by(email: sign_in_params[:email])

      if user&.valid_password?(sign_in_params[:password])
        sign_in(user)
        render json: {
          id: user.id,
          email: user.email,
          token: current_token,
          created_at: user.created_at,
          updated_at: user.updated_at
        }, status: :ok
      else
        render json: { error: 'Invalid Email or Password' }, status: :unauthorized
      end
    end

    private

    def sign_in_params
      params.require(:user).permit(:email, :password)
    end

    def current_token
      request.env['warden-jwt_auth.token']
    end
  end
end
