class RoomsController < ApplicationController
	before_action :right_user, only: :show
  def index
  	@requests     = current_user.request_creates.map(&:propose)
    @requested    = current_user.post_creates.map(&:propose)
  end

  def show
  	@room = Room.find(params[:id])
  	@message = Message.new
  	render :layout => nil
  end

  def destroy
  end

  private

  def right_user
    room = Room.find(params[:id])
    unless current_user.id == room.requestman.id || current_user.id == room.postman.id
    	redirect_to current_user
    end
  end
end
