# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user

  def index
    @user = current_user
    @users = User.all
  end

  def transfer_orders
    @user = current_user
    Services::TransferService.transfer_orders(@user.id, params[:getter_id])
    redirect_to users_path
  end

  def send_money
    @user = current_user
    Services::TransferService.transfer_money(@user.id, params[:getter_id] ,params[:money])

    redirect_to users_path
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.update(user_params)

    if @user.save
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def load_user
    @user = params[:id].present? ? User.find(params[:id]) : current_user
  rescue ActiveRecord::RecordNotFound
    render body: 'Not found', status: 404
  end

end
