class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit, :update, :destroy]#認可の順番も大事
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def index
  	@users = User.paginate(page: params[:page]).limit(3)
  end

	def show
		@user = User.find(params[:id])
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		@user.send_activation_email
  		#UserMailer.account_activation(@user).deliver_now
  		flash[:info] = "登録中のメールアドレスに確認メールを送信しました。"
  		redirect_to root_url
  		# flash[:success] = "ご登録ありがとうございます！"
  		# log_in @user
  		# redirect_to @user
  	else
  	 render 'new'
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  	else
  	 render 'edit'
    end
  end

  def destroy
  	User.find(params[:id]).destroy
  	flash[:success] = "User deleted"
  	redirect_to users_url
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
  	if not logged_in?
  		store_location
  		flash[:danger] = "ログインしてください"
  		redirect_to login_url
  	end
  end

  def correct_user
	   @user = User.find(params[:id])
	   redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
  	redirect_to(root_url) unless current_user.admin?
  end
end
