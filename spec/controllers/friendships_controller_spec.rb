# require 'rails_helper'

# RSpec.describe FriendshipsController, type: :controller do	
#  	before :each do
#  		@user = User.create(name: 'user', email: 'user@mail.com', password: 'password', password_confirmation: 'password')
#  		@another_user = User.create(name: 'another_user', email: 'another_user@mail.com', password: 'password', password_confirmation: 'password')
#  		@user.friendships.create(friend_id: @another_user.id)
#  	end



#  	context 'Add a friend' do
#  		it 'should not allow to add the same friend twice' do
#  			@friendship = @user.friendships.new(friend_id: @another_user.id)
#  			@find_friendship = Friendship.where(user_id: @friendship.user_id, friend_id: @friendship.friend_id)
#  			response = expect(@friendship.find_friendship).to be_truthy
#  		end
#  	end
# end

