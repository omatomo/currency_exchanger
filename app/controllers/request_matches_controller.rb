class RequestMatchesController < ApplicationController
  before_action :logged_in_user
  def create
  	current_user.request_creates.create(post_user_id: params[:post_user_id], propose_id: params[:propose_id])
    # room = Room.find_by(requestman_id: current_user.id, postman_id: params[:post_user_id], propose_id: params[:propose_id])
    room = Room.create(requestman_id: current_user.id, postman_id: params[:post_user_id], propose_id: params[:propose_id])
    Message.create(content: "#{current_user.name}です。よろしくお願いします！ ", user_id: current_user.id, room_id: room.id)
    redirect_to room_path room
    flash[:success] = "#{room.postman.name}さんにメッセージを送ろう！"
  end

  def destroy
  	# binding.pry
  	# request_match = RequestMatch.find_by(params[:id])
  	# propose = request_match.propose
  	current_user.request_creates.find_by(propose_id: params[:propose_id]).destroy
    Room.find_by(requestman_id: current_user.id, postman_id: params[:post_user_id], propose_id: params[:propose_id]).destroy
  	flash[:success] = "リクエストを削除しました。"
  	redirect_to root_url
  end
end
