require 'rails_helper'

RSpec.feature 'Likes', type: :feature do
	before :each do
		@user = User.create(name:'user', email: 'user@mail.com', password: 'password', password_confirmation: 'password')
		@post = @user.posts.create(body: 'Post body')
	end
	
	context 'Login successfull' do
		scenario 'should get to home' do
			visit new_user_session_path
			fill_in 'Email', with: @user.email
			fill_in 'Password', with: @user.password
			click_button 'Log in'
			click_link 'All posts'
			expect(page.current_path).to eq(posts_path)
			click_link '0 Like'
			expect(page).to have_content('1 Unlike')
		end
	end
end