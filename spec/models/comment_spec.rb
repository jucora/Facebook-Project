require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { Comment.create(body: 'Lorem Ipsum') }

  describe '#body' do
    it 'can\'t be empty' do
      comment.body = ''
      comment.valid?
      expect(comment.errors[:body]).to include("can't be blank")
    end

    it "can't exceed 2000 characters" do
      comment.body = 'a' * 2001
      comment.valid?
      expect(comment.errors[:body]).to include("is too long (maximum is 2000 characters)")
    end
  end

  it 'should belong to a user' do
    comment = Comment.reflect_on_association(:user)
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'should belong to a post' do
    comment = Comment.reflect_on_association(:post)
    expect(comment.macro).to eq(:belongs_to)
  end
end
