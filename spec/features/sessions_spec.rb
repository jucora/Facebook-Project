require 'rails_helper'

RSpec.feature 'Session', type: :feature do
	before :each do
		@user = User.create(name:'user', email: 'user@mail.com', password: 'password', password_confirmation: 'password')
	end

	context 'Login successfull' do
		scenario 'should get to home' do
			visit new_user_session_path
			fill_in 'Email', with: @user.email
			fill_in 'Password', with: @user.password
			click_button 'Log in'
			expect(page).to have_content('Signed in successfully.')
			click_link 'Profile'
			click_link 'My Profile'
			expect(page.current_path).to eq(user_path(id:@user.id))
			visit users_path
			click_link @user.name
			expect(page.current_path).to eq(user_path(id:@user.id))
		end
	end

	context 'Login with Facebook' do
		scenario 'should allow login with Facebook' do
			visit root_path
			expect(page).to have_link(nil, href: '/users/auth/facebook')
		end
	end

	context 'Incorrect login' do
		scenario 'should get back to new sessions view' do
			visit new_user_session_path
			fill_in 'Email', with: @user.email
			fill_in 'Password', with: 'pass'
			click_button 'Log in'
			expect(page).to have_content('Invalid Email or password.')
		end
	end

	context 'Logout' do
		scenario 'should logout the system' do
			visit new_user_session_path
			fill_in 'Email', with: @user.email
			fill_in 'Password', with: @user.password
			click_button 'Log in'
			click_link 'Profile'
			click_link 'Log Out'
			expect(page).to have_content('Signed out successfully.')
			visit user_path(id: @user.id)
			expect(page).to have_content('You need to sign in or sign up before continuing.')
		end
	end
end
