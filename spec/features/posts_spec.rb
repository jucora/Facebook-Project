require 'rails_helper'

RSpec.feature 'Post', type: :feature do
  before :each do
		user = User.create(name:'user', email: 'user@mail.com', password: 'password')
		another_user = User.create(name:'another_user', email: 'another_user@mail.com', password: 'password')
    @post = Post.create(body: 'testing', user_id: user.id)
	end

	context 'Post creation' do
		scenario 'should create a post when content is not empty' do
      visit new_user_session_path
			fill_in 'Email', with: 'user@mail.com'
			fill_in 'Password', with: 'password'
			click_button 'Log in'
			visit posts_new_path
			fill_in 'post[body]', with: 'testing'
			click_button 'Create post'
			expect(page).to have_content('Post created!')
		end

    scenario 'should display an error message for empty field' do
			visit new_user_session_path
      fill_in 'Email', with: 'user@mail.com'
			fill_in 'Password', with: 'password'
			click_button 'Log in'
			visit posts_new_path
      fill_in 'post[body]', with: ''
			click_button 'Create post'
			expect(page).to have_content('Can\'t be blank')
		end
	end

	context 'Post update' do
    scenario 'should display the update link when user is the post creator' do
      visit new_user_session_path
			fill_in 'Email', with: 'user@mail.com'
			fill_in 'Password', with: 'password'
			click_button 'Log in'
			visit post_path(@post)
			expect(page).to have_link('update', href: "/posts/#{@post.id}/edit")
		end

		scenario 'should not display the update link when user is not the post creator' do
      visit new_user_session_path
			fill_in 'Email', with: 'another_user@mail.com'
			fill_in 'Password', with: 'password'
			click_button 'Log in'
			visit post_path(@post)
			expect(page).to_not have_link('update')
		end
	end 
end
