class MessagesController < ApplicationController
  def create
  	message = Message.new(message_params)
  	if message.save
  	  room = Room.find(params[:room_id])
  	  redirect_to room
  	else
  		redirect_to :back
  		flash[:danger] = "メッセージは１文字以上２５０文字以内です。"
  	end
  end

  def index
  end

  def destroy
  	message = Message.find(params[:id])
  	message.destroy
  	redirect_to :back
  end

  private

  def message_params
  	params.require(:message).permit(:content).merge(user_id: current_user.id, room_id: params[:room_id])
  end
end
