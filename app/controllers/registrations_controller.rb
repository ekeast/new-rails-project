class RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @registrations = current_user.registrations
  end

  def show
    @registration = Registration.find(params[:id])
    @events = @registration.events.group_by(&:name)
  end

  def new
    @registration = Registration.new
  end

  def edit
    @registration = Registration.find(params[:id])
  end

  def create
    @registration = current_user.registrations.new(registration_params)

    if @registration.save
      flash[:notice] = "Website has been registered."
      redirect_to registrations_path
    else
      flash.now[:alert] = "There was an error registering the website."
      render :new
    end
  end

  def destroy
    @registration = Registration.find(params[:id])

    if @registration.destroy
      flash[:notice] = "\"#{@registration.name}\" was deleted successfully."
      redirect_to registrations_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :index
    end
  end

  private

  def registration_params
    params.require(:registration).permit([:name, :url])
  end
end
