require 'rails_helper'

RSpec.describe "TweetsController", type: :request do
  describe "GET /index" do
    let!(:tweet) { create(:tweet) }

    it 'assigns all tweets as @tweets' do
      get root_path
      expect(response.status).to eq(200)
      # debugger
      expect(:tweets).to eq([tweet])
    end
  end
end
