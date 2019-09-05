class RegistrationsController < ApplicationController
  before_action :load_all, only: %i[new]
  before_action :find_registration, only: %i[show]

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(set_params)
    if @registration.save
      redirect_to @registration
    else
      flash.now[:alert] = 'Todos os campos devem estar preenchidos.'
      load_all
      render :new
    end
  end

  def show; end

  private

  def set_params
    params.require(:registration).permit(:name, :email, :unity_id, :plan_id)
  end

  def find_registration
    @registration = Registration.find(params[:id])
  end

  def load_all
    @unity = Unity.all
    @plan = Plan.all
  end
end
