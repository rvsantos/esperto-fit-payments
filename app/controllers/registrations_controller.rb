class RegistrationsController < ApplicationController
  before_action :load_all, only: %i[new]
  before_action :find_registration, only: %i[show]
  before_action :authenticate_user!
  before_action :auth_admin

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(set_params)
    generate_payment
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
    params.require(:registration).permit(:name, :email, :cpf, :unity_id, :plan_id)
  end

  def find_registration
    @registration = Registration.find(params[:id])
  end

  def load_all
    @unity = Unity.all
    @plan = Plan.all
  end

  def auth_admin
    redirect_to new_user_session_path unless current_user.admin?
  end

  def generate_payment
    12.times do |i|
      @registration.payments.new(value: @registration.plan.value, due_date: Time.zone.now.to_date + i.month)
    end
  end
end