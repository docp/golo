class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @friends = @user.followers(@user.id) + @user.following(@user.id)
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login @user
      redirect_to @user
      flash[:success] = "Welcome to the Track Database"
    else
      @title = "Sign up"
      render :new
    end
  end
end

