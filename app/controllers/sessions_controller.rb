class SessionsController < ApplicationController
    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged Out!"
    end

    def new 
    end

    def create 
        user = User.find_by(email: params[:email])
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: "Logged in successfully!"
        else
            flash[:alert] = "Invalid email or password!"
            render :new 
        end
    end
end