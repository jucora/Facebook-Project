class FriendshipsController < ApplicationController
  before_action :find_friend, only: %i[create destroy]

  def create
    @friendship = current_user.friendships.create(friend_id: @friend.id)
    if @friendship.save
      flash[:notice] = 'Request sent!'
      redirect_to users_path
    else
      flash[:alert] = 'Something went wrong'
      redirect_to users_path
    end
  end

  def accept
    
  end

  def destroy

  end

  private

  def find_friend
    @friend = User.find(params[:id])
  end
end
