class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:index, :edit, :update, :destroy]

  def index
    @users = User.all.sort_by { |u| u[:firstName] }
  end

  def show
    @posts = @user.posts.reverse.paginate(:page => params[:page], :per_page => 8)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    session[:remember_token] = @user.id.to_s
    if @user.save
      flash[:success] = "You have signed up successfully"
      redirect_to :root
    else
      render :new
    end
  end

  def update
    
  end

  def destroy
    
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:firstName, :lastName, :email, :about, :password, :password_confirmation, :picture)
    end
end
