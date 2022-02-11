require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  describe "GET /index" do
    let!(:tweet) { create(:tweet) }

    it 'assigns all tweets as @tweets' do
      get :index
      expect(response.status).to eq(200)
      debugger
      expect(:tweets).should eq([tweet])
    end
  end
end
