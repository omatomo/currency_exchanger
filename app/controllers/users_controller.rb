class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]#認可の順番も大事
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def index
  	@users = User.paginate(page: params[:page]).limit(15)
  end

	def show
		@user         = User.find(params[:id])
    @my_proposes  = @user.proposes
    @my_likes     = @user.likes.map(&:propose)
    @requests     = @user.request_creates.map(&:propose)

    requests      = @user.request_creates
    matched_request = []
    requests.each do |request|
      if request.negotiated == true
        matched_request << request.propose
      end
    end
    @matched_request = matched_request
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
      flash[:success] = "編集に成功しました。"
      redirect_to root_url
  	else
  	 render 'edit'
    end
  end

  def destroy
  	User.find(params[:id]).destroy
  	flash[:success] = "User deleted"
  	redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end


  def admin_user
  	redirect_to(root_url) unless current_user.admin?
  end
end
