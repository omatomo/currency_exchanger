class SessionsController < ApplicationController
  def new
  end

  def create #session = ログインの本質はlog_inメソッドとそれによって取れるcurrent_user
  	@user = User.find_by(email: params[:session][:email].downcase)
  	if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
    		log_in @user
    		params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
    		redirect_back_or proposes_path
        flash[:success] = "ログインに成功しました。"
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
  	else
  		flash.now[:danger] = "パスワードとメールアドレスの組み合わせが間違っています。"
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
