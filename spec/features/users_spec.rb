require 'rails_helper'

RSpec.feature 'User', type: :feature do
	context 'Sign up successful' do
		scenario 'should register the user' do
			visit new_user_registration_path
			fill_in 'Name', with: 'hugo'
			fill_in 'Email', with: 'hugo@mail.com'
			fill_in 'Password', with: 'password'
			fill_in 'user_password_confirmation', with: 'password'
			click_button 'Sign up'
			expect(page).to have_content('Welcome! You have signed up successfully.')
		end
	end

	context 'Incorrect login' do
		scenario 'should display error messages for empty fields' do
			visit new_user_registration_path
			fill_in 'Name', with: 'hugo'
			fill_in 'Email', with: 'hugo@mail.com'
			fill_in 'Password', with: ''
			fill_in 'user_password_confirmation', with: 'password'
			click_button 'Sign up'
			expect(page).to have_content('errors prohibited this user from being saved')
		end
	end
end