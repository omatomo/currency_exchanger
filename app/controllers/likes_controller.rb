class LikesController < ApplicationController
  def create
  	@like = Like.create(user_id: current_user.id, propose_id: params[:propose_id])
    redirect_to :back
  end

  def destroy
  	Like.find_by(user_id: current_user.id, propose_id: params[:propose_id]).destroy
    @propose = Propose.find(params[:propose_id])
    redirect_to :back
  end
end
