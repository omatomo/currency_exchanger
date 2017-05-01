class ProposesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy, :show]
  before_action :right_user,     only: [:edit, :update, :destroy]
  def new
    @propose = Propose.new
  end

  def create
    @propose = Propose.new(propose_params)
    if @propose.save
      flash[:success] = "投稿を完了しました。リクエストを待ちましょう"
      redirect_to root_url
    else
      flash[:danger] = "もう一度確認お願いします。"
      render 'new'
    end
  end

  def edit
    @propose = Propose.find(params[:id])
  end

  def update
    @propose = Propose.find(params[:id])
    if @propose.update_attributes(propose_params)
      flash[:success] = "編集に成功しました。"
      redirect_to proposes_path
    end
  end

  def destroy
    Propose.find(params[:id]).destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to proposes_path
  end

  def index
    @proposes = Propose.paginate(page: params[:page]).limit(5)
  end

  def show
    @propose = Propose.find(params[:id])
  end

  private
  def propose_params
    params.require(:propose).permit(:comment, :amount, :have_currency_id, :want_currency_id).merge(user_id: current_user.id)
  end

  def right_user
    @propose = Propose.find(params[:id])
    flash[:alert] = "ログインしてください。"
    redirect_to(root_url) unless current_user?(@propose.user)
  end
end
