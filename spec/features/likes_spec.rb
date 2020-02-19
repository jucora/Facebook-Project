require 'rails_helper'

RSpec.feature 'Likes', type: :feature do
	before :each do
		@user = User.create(name:'user', email: 'user@mail.com', password: 'password', password_confirmation: 'password')
		@post = @user.posts.create(body: 'Post body')
	end
	
	context 'Displaying all posts' do
		scenario 'should display the like icon' do
			visit new_user_session_path
			fill_in 'Email', with: @user.email
			fill_in 'Password', with: @user.password
			click_button 'Log in'
			click_link 'All posts'
			expect(page.current_path).to eq(posts_path)
			find('i[class="far fa-thumbs-up"]')
		end
	end
end



