class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def friends
  	@friends = current_user.friends
  end

  def friends_pending
  	@friends_pending = current_user.friends_pending
  end
end
