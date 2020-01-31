require 'rails_helper'

RSpec.feature 'Session', type: :feature do
	before :each do
		User.create(name:'user', email: 'user@mail.com', password: 'password')
	end
	context 'Login successfull' do
		scenario 'should get to home' do
			visit new_user_session_path
			fill_in 'Email', with: 'user@mail.com'
			fill_in 'Password', with: 'password'
			click_button 'Log in'
			expect(page).to have_content('Signed in successfully.')
		end
	end

	context 'Incorrect login' do
		scenario 'should get back to new sessions view' do
			visit new_user_session_path
			fill_in 'Email', with: 'user@mail.com'
			fill_in 'Password', with: 'pass'
			click_button 'Log in'
			expect(page).to have_content('Invalid Email or password.')
		end
	end
end