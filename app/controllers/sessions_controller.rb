class SessionsController < ApplicationController
    def create
        user = User.find_by(name: params[:session][:name])
        if user 
            session[:user_id] = user.id
            redirect_to tasks_path
        else
            render 'home/index'
        end
    end
  
    def destroy
      session.delete(:user_id)
      redirect_to root_path
    end
  end
  