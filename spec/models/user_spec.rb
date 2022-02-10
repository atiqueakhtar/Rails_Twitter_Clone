require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures username is present' do
      user = User.new(email: "abc@gmail.com", password: "123", password_confirmation: "123")
      expect(user.save).to eq(false)
    end

    it 'ensures email is present' do
      user = User.new(password: "123", password_confirmation: "123", username: "abc")
      expect(user.save).to eq(false)
    end

    it 'ensures user creates on proper input' do
      user = FactoryBot.create(:user)
      expect(user.save).to eq(true)
    end
  end

end
