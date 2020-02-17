module UsersHelper

	# The User Helper Methods will evaluate if a user is included in the arrays returned by the User Friendship methods

	def friends(u)
		current_user.friends.include?(u)
	end

	def friendships_confirmed(u)
		current_user.friendships_pending.include?(u)
	end

	def inverse_friendships_confirmed(u)
		current_user.inverse_friendships_pending.include?(u)
	end

	def friendships_pending(u)
		current_user.friendships_pending.include?(u)
	end

	def inverse_friendships_pending(u)
		current_user.inverse_friendships_pending.include?(u)
	end

	# This method will return at most the 9 last friends added by the user

	def show_nine_friends(user)
		# The variable limit will bring the nth last friend added by the user
		limit = user.friends.length * -1
		limit >= -9 ? user.friends[limit..-1] : user.friends[-9..-1]
	end
end
