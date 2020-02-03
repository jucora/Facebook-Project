require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name:'john', email:'john@mail.com', password: 'password', password_confirmation: 'password') }
  let(:another_user) { User.create(name:'john', email:'john@mail.com', password: 'password', password_confirmation: 'password') }

  describe '#name' do
  	it 'should have a name' do
  		user.name = ''
  		user.valid?
  		expect(user.errors[:name]).to include("can't be blank")
  	end

  	it 'should have at least 2 characters' do
  		user.name = 'a'
  		user.valid?
  		expect(user.errors[:name]).to include("is too short (minimum is 2 characters)")
  	end

  	it 'should have a maximum of 50 characters' do
  		user.name = 'a' * 51
  		user.valid?
  		expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
  	end
  end

  describe '#email' do
  	it 'should have an email' do
  		user.email = ''
  		user.valid?
  		expect(user.errors[:email]).to include("can't be blank")
  	end

  	it 'should have a valid format' do
  		user.email = 'user'
  		user.valid?
  		expect(user.errors[:email]).to include('is invalid')
  	end

  	it 'should be unique' do
  		another_user.valid?
  		expect(user.errors[:email]).to include('has already been taken')
  	end
  end

  describe '#password' do
  	it 'should have a minimum of 6 characters' do
  		user.password = 'pass'
  		user.valid?
  		expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  	end

  	it 'should have a password' do
  		user.password = ''
  		user.valid?
  		expect(user.errors[:password]).to include("can't be blank")
  	end
  end

  describe '#password confirmation' do
  	it 'should match the password' do
  		user.password = 'password'
  		user.password_confirmation = 'pass'
  		user.valid?
  		expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  	end
  end

  it 'should have many posts' do
    user = User.reflect_on_association(:posts)
    expect(user.macro).to eq(:has_many)
  end
end
