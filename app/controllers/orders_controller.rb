# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user

  def index
    @user = current_user
    orders = Services::SearchOrderService.search(params[:search], params[:kladr], @user)
    @orders = orders.paginate(page: params[:page])
    @comments = Services::CommentService.find_comments(@orders)
  end

  def change
    order = Order.find(params[:id])
    @user = current_user
    order.update(status: params[:status])
    redirect_to orders_path(page: params[:page], search: params[:search], kladr: params[:kladr])
  end

  def load_user
    @user = params[:user_id].present? ? User.find(params[:user_id]) : current_user
  rescue ActiveRecord::RecordNotFound
    render body: 'Not found', status: 404
  end
  def show; end

  def new; end
end
