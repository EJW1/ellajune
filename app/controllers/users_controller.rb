class UsersController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :interest_tag, :name, :class_name => 'interest_tag'
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.create( params[:user] )
  end

  def index
    if params[:search]
      @users = User.search(params[:search]).paginate(:page => params[:page], :per_page => 30)
    elsif params[:interest_tag]
      @users = User.tagged_with(params[:interest_tag]).paginate(:page => params[:page], :per_page => 30)
    elsif params[:citysearch]
      @users = User.citysearch(params[:citysearch]).paginate(:page => params[:page], :per_page => 30)    
    else
      @users = User.all.paginate(:page => params[:page], :per_page => 30)
    end
  end
end