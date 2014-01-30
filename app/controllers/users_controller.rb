class UsersController < ApplicationController
  respond_to :html, :only => :grid
  respond_to :json, :except => :grid
  before_action :set_user, only: [:update, :destroy]

  #GET /users/grid
  def grid
    @users = User.all
  end
  
  # GET /users
  def index
    @users = User.all
    respond_with(@users, :success => true)
  end

  # POST /users
  def create
    @user = User.new
    if @user.save
      render :json => { :success => true, :message => "Created new User #{@user.id}", :users => @user }
    else
      render :json => { :message => "Failed to create user"}
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render :json => { :success => true, :message => "Updated User #{@user.id}", :users => @user }
    else
      render :json => { :message => "Failed to update User"}
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.destroy
      render :json => { :success => true, :message => "Destroyed User #{@user.id}" }
    else
      render :json => { :message => "Failed to destroy User" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
