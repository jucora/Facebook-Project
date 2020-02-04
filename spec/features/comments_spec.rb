require 'rails_helper'

RSpec.feature 'Comment', type: :feature do
  before :each do
		user = User.create(name:'user', email: 'user@mail.com', password: 'password')
    @post = Post.create(body: 'testing', user_id: user.id)
    @comment = Comment.create(body: 'testing', post_id: @post.id, user_id: user.id)
	end

	context 'Comment creation' do
		scenario 'should create a comment when content is not empty' do
      visit new_user_session_path
			fill_in 'Email', with: 'user@mail.com'
			fill_in 'Password', with: 'password'
			click_button 'Log in'
      visit post_path(@post.id)
			fill_in 'comment[body]', with: 'testing'
			click_button 'Post my comment'
			expect(page).to have_content('Comment created!')
		end

    scenario 'should display an error message for empty field' do
      visit new_user_session_path
			fill_in 'Email', with: 'user@mail.com'
			fill_in 'Password', with: 'password'
			click_button 'Log in'
      visit post_path(@post.id)
			fill_in 'comment[body]', with: ''
			click_button 'Post my comment'
			expect(page).to have_content('Something went wrong')
		end
  end
end
