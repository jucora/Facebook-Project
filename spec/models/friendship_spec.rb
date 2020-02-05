require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.create(name:'john', email:'john@mail.com', password: 'password', password_confirmation: 'password') }
  let(:friend) { User.create(name:'ana', email:'ana@mail.com', password: 'password', password_confirmation: 'password') }
  let(:friendship) { Friendship.create(user_id: user.id, friend_id: friend.id ) }
end
