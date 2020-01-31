require 'rails_helper'

RSpec.feature 'Post', type: :feature do
  before :each do
		User.create(name:'user', email: 'user@mail.com', password: 'password')
	end

	context 'Successfully create a post' do
		scenario 'should create a post' do
      visit new_user_session_path
			fill_in 'Email', with: 'user@mail.com'
			fill_in 'Password', with: 'password'
			click_button 'Log in'
			visit posts_new_path
			fill_in 'post[body]', with: 'testing'
			click_button 'Create post'
			expect(page).to have_content('Post created!')
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
