class RequestMatchesController < ApplicationController
  def create
  	current_user.request_creates.create(post_user_id: params[:post_user_id], propose_id: params[:propose_id])
  	redirect_to root_url
  end

  def destroy
  	# binding.pry
  	# request_match = RequestMatch.find_by(params[:id])
  	# propose = request_match.propose
  	current_user.request_creates.find_by(propose_id: params[:propose_id]).destroy
  	flash[:success] = "リクエストを削除しました。"
  	redirect_to root_url
  end
end
