class ActivationsController < ApplicationController
	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated? && user.authenticated?(:activation, params[:id])
			user.activate
			log_in user
			flash[:success] = "認証が完了しました"
			redirect_to user
		else
			flash[:danger] = "有効なリンクではありません"
			redirect_to root_url
		end
	end
end
#本来createアクションやupdateアクションで行う流れを、viewを表示するなどの役割だったeditアクション内で行なっている。それはなぜか？それはブラウザの使用上メールのリンクをクリックしたら送られるのはgetリクエストのみ。なのでpostリクエスト、patchリクエストをハンドリングできない。editアクションで妥協している。
