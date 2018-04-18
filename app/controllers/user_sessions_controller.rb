class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # puts '**************************'
    # puts params.inspect
    # puts '**************************'
    if login(params[:email], params[:password])
      redirect_back_or_to(posts_path, notice: 'Login successful')

    else
      # This doesn't seem to be working.
      flash.now.alert = "Login failed."
      render action: :new
    end
  end

  def destroy
    puts '**************************'
    puts params.inspect
    puts '**************************'
    reset_session
    redirect_to(login_path, notice: "Logged out")
  end
end
