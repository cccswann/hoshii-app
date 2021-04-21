class UsersController < ApplicationController
    #before_action :authorize, only: [:show]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to '/'
        else
            render 'new'
        end
    end

    def index
        @users = User.all
    end

    def show
       if !!current_user
            @user = User.find_by(params[:id])
       else
            redirect_to '/'
       end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
