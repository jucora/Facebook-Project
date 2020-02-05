require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { Post.create(body: 'Lorem Ipsum') }
  let(:user) { User.create(name:'john', email:'john@mail.com', password: 'password', password_confirmation: 'password') }

  describe '#body' do
    it 'can\'t be empty' do
      post.body = ''
      post.valid?
      expect(post.errors[:body]).to include("can't be blank")
    end

    it 'should not exceed 2000 characters' do
      post.body = 'a' * 2001
      post.valid?
      expect(post.errors[:body]).to include('is too long (maximum is 2000 characters)')
    end
  end

  it 'should belong to a user' do
    post = Post.reflect_on_association(:user)
    expect(post.macro).to eq(:belongs_to)
  end

  it 'should have many likes' do
    post = Post.reflect_on_association(:likes)
    expect(post.macro).to eq(:has_many)
  end
end
