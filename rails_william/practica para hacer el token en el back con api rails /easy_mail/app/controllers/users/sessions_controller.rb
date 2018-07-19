# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end
   #verifica el password que me envia el cliente comparandolo con el que esta almacenado en el servidor 
  # POST /resource/sign_in
  def create
    token_command = AuthenticateUserCommand.call(*user_params.slice(:email, :password).values)
    if token_command.success?
      render json: { token: token_command.result }
    else
      render json: { error: token_command.errors }, status: :unauthorized
    end
  end
  private
    def user_params
      params.permit(:email,:password)      
    end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
