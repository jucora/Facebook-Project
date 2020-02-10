module UsersHelper

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
