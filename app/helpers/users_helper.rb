module UsersHelper
  def has_friend(friend, current_user_id, confirmed = true)
    friend.inverse_friendships.find_by(user_id: current_user_id, confirmed: confirmed)
  end
end
