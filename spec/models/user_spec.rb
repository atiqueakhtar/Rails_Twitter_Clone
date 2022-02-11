require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures username is present' do
      user = build(:user, username: nil)
      expect(user.save).to eq(false)
    end

    it 'ensures email is present' do
      user = build(:user, email: nil)
      expect(user.save).to eq(false)
    end

    it 'ensures user creates on proper input' do
      user = create :user
      expect(user.save).to eq(true)
    end
  end

end
