# created using the scaffold controller
class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  #
  # before_action :zero_users_or_authenticated, only: [:create]

  # The below keeps the user from going to /users page. Will automatically redirect to root
  before_action :require_login, except: [:new, :create]

  def zero_users_or_authenticated
    unless User.count == 0 || current_user
      redirect_to root_path
      return false
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    puts '*************************'
    puts params.inspect
    puts '*************************'
    @user = User.find(params[:id])
    @posts = @user.posts.reverse
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to new_user_path, notice: @user.errors.full_messages[0] }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
  # This will delete the user.
    @user = User.find(params[:id])
  # The below deletes the user's posts when the user is deleted.
  #   @posts = Post.all
  #   @posts.each do |post|
  #     if post.user_id == @user.id
  # 	  post.delete
  #   end
  # end
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
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
