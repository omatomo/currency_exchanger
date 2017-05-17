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
      flash.now[:danger] = "もう一度確認お願いします。"
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
    propose = Propose.find(params[:id]).destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to proposes_path
  end

  def index
    # @proposes = Propose.paginate(page: params[:page]).limit(8)
  end

  def show
    @propose = Propose.find(params[:id])
  end

  def search
    have         = params[:propose][:have_currency_id]
    want         = params[:propose][:want_currency_id]
    hello        = Currency.find(have) if !have.blank?
    thanks       = Currency.find(want) if !want.blank?
    # hello_image  =  view_context.image_path hello.image
    # thanks_image =  view_context.image_path thanks.image

    if want.present? && have.present?
      proposes = Propose.where(have_currency_id: want).where(want_currency_id: have)
      if proposes.blank?
        @proposes = "該当する結果は見つかりませんでした。"
        render 'index'
      else
        @proposes = proposes.paginate(page: params[:page]).limit(5)
        flash.now[:success] = "#{thanks.currency} を所持している人と, #{hello.currency} を必要としている人の検索結果一覧です。"
        render 'index'
      end
    elsif want.blank? && have.blank?
      flash.now[:danger] = "不正な値です。"
      # @proposes = Propose.paginate(page: params[:page]).limit(5)
      render 'index'
    elsif have && want.blank?
      proposes = Propose.where(want_currency_id: have)
      if proposes.blank?
        @proposes = "該当する結果は見つかりませんでした。"
        render 'index'
      else
        @proposes = proposes.paginate(page: params[:page]).limit(5)
        flash.now[:success] = "#{hello.currency} を必要としている人の検索結果一覧です。"
        render 'index'
      end
    elsif want && have.blank?
      proposes = Propose.where(have_currency_id: want)
      if proposes.blank?
        @proposes = "該当する結果は見つかりませんでした。"
        render 'index'
      else
        @proposes = proposes.paginate(page: params[:page]).limit(5)
        flash.now[:success] = "#{fack.currency} を所持している人の検索結果一覧です。"
        render 'index'
      end
    end
  end

  private
  def propose_params
    params.require(:propose).permit(:comment, :amount, :have_currency_id, :want_currency_id).merge(user_id: current_user.id)
  end

  def right_user
    @propose = Propose.find(params[:id])
    redirect_to(login_url) unless current_user?(@propose.user)
  end
end
