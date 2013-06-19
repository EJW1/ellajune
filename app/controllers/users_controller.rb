class UsersController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :interest_tag, :name, :class_name => 'interest_tag'
  
  def show
    @user = User.find(params[:id])
  end

  def index
    if params[:search]
      @users = User.search(params[:search])
    elsif params[:interest_tag]
      @users = User.tagged_with(params[:interest_tag])
    else
      @users = User.all
    end
  end
end