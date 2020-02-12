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
end
