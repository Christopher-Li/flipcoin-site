class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :if_logged_in_redirect, only: [:newindividual, :newentity]
  before_action :user_must_be_admin, only: [:index]
  # GET /users
  # GET /users.json
  def index
    @users = User.all.order('id')
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # Can only view page if you are an admin or the logged in user
    if current_user && (current_user.admin || current_user.id.to_f == params[:id].to_f)
    else
      redirect_to current_user
    end
  end

  # GET /users/1/edit
  def edit
    curr = current_user
    if curr && curr.admin
    elsif curr
      redirect_to curr
    else
      redirect_to log_in
    end
  end

  def new
    @user = User.new
  end

  # POST /signup/individual
  def createUser(signature, usersName, err)
    logger.debug "User params: #{@user.firstName} #{@user.lastName} #{params[:signature]}"
    if @user.valid?
      if signature.downcase != usersName.downcase
        @user.errors.add(:signature, err)
        true
      else
        @user.save
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
        false
      end
    else
      @user.save
      if signature.downcase != usersName.downcase
        @user.errors.add(:signature, err)
      end
      true
    end
  end

  def newindividual
    @user = User.new
  end

  # POST /signup/individual
  def createindividual
    @user = User.new(user_params)
    @user.admin = false
    @user.isEntity = false
    @user.organizationType = ""
    params[:organizationType].each do |key, value|
      if value != "0" then
        @user.organizationType += " & " + value
      end
    end
    
    if createUser(params[:signature]['sig'], @user.firstName + " " + @user.lastName, "must be 'firstName lastName'")
      if not @user.errors[:organizationType].empty?
        @user.errors.delete(:organizationType)
        @user.errors.add(:Must, "select an individual type.")
      end
      render 'newindividual'
    end
  end

  def newentity
    @user = User.new
    organizationType = {}
  end

  # POST /signup/entity
  def createentity
    @user = User.new(user_params)
    @user.admin = false
    @user.isEntity = true
    @user.lastName = "N/A"
    @user.citizenship = "N/A"
    @user.organizationType = ""
    params[:organizationType].each do |key, value|
      if value != "0" then
        @user.organizationType += " & " + value
      end
    end
    
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      if not @user.errors[:organizationType].empty?
        @user.errors.delete(:organizationType)
        @user.errors.add(:Must, "select an entity type.")
      end
      render 'newentity'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params_wa_np)
      flash[:info] = "User was successfully updated."
      redirect_to @user
      # format.json { render :show, status: :ok, location: @user }
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :firstName, 
        :lastName, 
        :email, 
        :password, 
        :password_confirmation, 
        :ethAdd, 
        :bitAdd, 
        :estimatedContribution, 
        :phoneNumber,
        :address1,
        :address2,
        :city,
        :state,
        :zipCode,
        :dob,
        :citizenship,
        :socialsecurity)
    end

    def user_params_wa_np
      params.require(:user).permit(
        :firstName, 
        :lastName, 
        :email, 
        :ethAdd,
        :bitAdd,
        :estimatedContribution,
        :phoneNumber,
        :address1,
        :address2,
        :city,
        :state,
        :zipCode,
        :dob,
        :citizenship,
        :socialsecurity)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def if_logged_in_redirect
      if logged_in?
        redirect_to current_user
      end
    end

    def user_must_be_admin
      if !current_user
        flash[:danger] = "Please log in."
        redirect_to login_url
      elsif !current_user.admin
        flash[:danger] = "You must be an admin to view this page."
        redirect_to current_user
      end
    end
end
