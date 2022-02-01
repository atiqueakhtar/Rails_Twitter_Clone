class PasswordResetsController < ApplicationController
    def new 
    end

    def create  
        @user = User.find_by(email: params[:email])
        if @user.present?
            #send email 
            PasswordMailer.with(user: @user).reset.deliver_now
        end
        redirect_to root_path, notice: "If an account exists, email sent to reset password!"
    end

    def edit
        @user = User.find_signed!(params[:token], purpose: "password_reset")
    end

    def update
        @user = User.find_signed!(params[:token], purpose: "password_reset")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: "Password is reset!"
        else
            render :edit
        end
    end

    private
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end