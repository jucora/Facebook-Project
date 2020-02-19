require 'rails_helper'

RSpec.feature 'Friendship', type: :feature do
	let(:user) { User.create(name:'john', email:'john@mail.com', password: 'password', password_confirmation: 'password') }
  let(:another_user) { User.create(name:'john', email:'john@mail.com', password: 'password', password_confirmation: 'password') }
  let(:user2) { User.create(name:'user2', email:'user2@mail.com', password: 'password', password_confirmation: 'password') }
  let(:user3) { User.create(name:'user3', email:'user3@mail.com', password: 'password', password_confirmation: 'password') }

  before(:each) do
    user.friendships.create(friend_id: user2.id, confirmed: true)
    user.friendships.create(friend_id: user3.id)
  end

  context 'Adding a friend' do
  	scenario 'should prevent users from adding the same friend twice by using the method find_friendship in FriendshipsController' do
  		visit new_user_session_path
			fill_in 'Email', with: user.email
			fill_in 'Password', with: user.password
			click_button 'Log in'
			rack_test_session_wrapper = Capybara.current_session.driver
			rack_test_session_wrapper.submit :post, friendships_path(id: user2.id), nil
			expect(page).to have_content("Can't add the same friend twice")
  	end
  end

	context 'Display user friends' do
		scenario 'should display the button to delete a friend and cancel a sent request' do
      visit new_user_session_path
			fill_in 'Email', with: user.email
			fill_in 'Password', with: user.password
			click_button 'Log in'
			visit users_friends_path
			expect(page).to have_content('Your Friends')
			expect(page).to have_content(user2.name)
			expect(page).to have_selector(:link_or_button, 'Delete')
			expect(page).to_not have_content(user3.name)
			visit users_path
			expect(page).to have_content('Users')
			expect(page).to have_selector(:link_or_button, 'Delete friend')
			expect(page).to have_selector(:link_or_button, 'Cancel request')
		end
	end

	context 'Display requests that a user receives' do
		scenario 'should display the button to accept or reject a request' do
      visit new_user_session_path
			fill_in 'Email', with: user3.email
			fill_in 'Password', with: user3.password
			click_button 'Log in'
			visit users_friends_pending_path
			expect(page).to have_content('Your friend requests')
			expect(page).to have_content(user.name)
			expect(page).to have_selector(:link_or_button, 'Accept')
			expect(page).to have_selector(:link_or_button, 'Reject')
		end

		scenario 'should not display the button to accept or reject when user sends a request' do
      visit new_user_session_path
			fill_in 'Email', with: user.email
			fill_in 'Password', with: user.password
			click_button 'Log in'
			visit users_friends_pending_path
			expect(page).to have_content('Your friend requests')
			expect(page).to_not have_content(user3.name)
			expect(page).to_not have_selector(:link_or_button, 'Accept')
			expect(page).to_not have_selector(:link_or_button, 'Reject')
		end
	end		
end