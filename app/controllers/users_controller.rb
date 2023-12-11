class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:alert] = "L'utilisateur que vous cherchez n'existe pas."
      redirect_to user_path(current_user)
    elsif current_user != @user
      flash[:notice] = "Vous n'êtes pas autorisé à accéder à ce profil."
      redirect_to user_path(current_user)
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :email, :password, :password_confirmation, :current_password, :avatar)
  end
end
