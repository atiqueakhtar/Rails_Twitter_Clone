require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  describe "GET /index" do
    it 'checks for correct page render' do
      tweets = create :tweet

      get :index

      expect(response.status).to eq(200)
      expect(response).to render_template("index")
    end

    it 'ensures all tweets are shown when user logged out' do
      Current.user = create :user
      session[:user_id] = nil
      tweet1 = create :tweet

      get :index

      expect(assigns(:tweets)).to match_array(Tweet.all)
    end

    it 'ensures correct tweets are shown when user logged in' do
      Current.user = create :user
      session[:user_id] = Current.user.id
      followee1 = create :user
      create :relation, follower: Current.user, followee: followee1
      tweet1 = create :tweet, user: followee1

      get :index

      expect(assigns(:tweets)).to match_array(Tweet.find(tweet1.id))
    end
  end

  describe "GET /show" do
    it 'renders show page' do
      tweet = create :tweet_with_replies

      get :show, params: {id: tweet.id}
      expect(response.status).to eq(200)
      expect(response).to render_template("show")
    end

    it 'ensures correct tweet and replies are shown' do
      tweet = create :tweet_with_replies
      
      get :show, params: {id: tweet.id}

      expect(assigns(:tweet)).to eq(tweet)
      expect(assigns(:replies)).to match_array(tweet.replies)
    end
  end

  describe "POST /create" do
    it 'checks response for create' do
      tweet = create :parent_tweet
      Current.user = tweet.user

      post :create, params: {body: tweet.body}

      expect(response.status).to eq(302)
    end

    it 'creates new tweet' do
      tweet = create :parent_tweet
      Current.user = tweet.user
      
      post :create, params: {body: tweet.body}

      expect(assigns(:tweet).body).to eq(tweet.body)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE /destroy" do
    it 'checks response for destroy' do
      tweet = create :parent_tweet

      delete :destroy, params: {id: tweet.id}

      expect(response.status).to eq(302)
    end

    it 'destroys tweet' do
      tweet = create :parent_tweet
      
      delete :destroy, params: {id: tweet.id}

      expect{ Tweet.find(tweet.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /likes" do
    it 'renders likes page' do
      tweet = create :tweet_with_likes
      users = tweet.liked_by

      get :likes, params: {id: tweet.id}

      expect(response.status).to eq(200)
      expect(response).to render_template("likes")
    end

    it 'ensures users who have liked the tweet are only shown' do
      tweet = create :tweet_with_likes
      users = tweet.liked_by

      get :likes, params: {id: tweet.id}

      expect(assigns(:users)).to match_array(users)
    end
  end

  describe "POST /add_like" do
    it 'renders likes page' do
      tweet = create :parent_tweet
      like = create :like, tweet: tweet

      post :add_like, params: {id: tweet.id}

      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end

    it 'likes tweet if not already liked' do
      tweet = create :parent_tweet
      Current.user = create :user

      post :add_like, params: {id: tweet.id}

      expect(tweet.liked_by).to include(Current.user)
    end

    it 'removes like if already liked' do
      tweet = create :parent_tweet
      like = create :like, tweet: tweet
      Current.user = like.user

      expect{ post :add_like, params: {id: tweet.id} }.to change { tweet.likes.count }.by(-1)
    end
  end

  describe "GET /retweets" do
    it 'renders retweets page' do
      tweet = create :tweet_with_retweets
      retweets = tweet.retweets

      get :retweets, params: {id: tweet.id}

      expect(response.status).to eq(200)
      expect(response).to render_template("retweets")
    end

    it 'ensures who have retweeted the tweet are only shown' do
      tweet = create :tweet_with_retweets
      retweets = tweet.retweets

      get :retweets, params: {id: tweet.id}

      expect(assigns(:tweets)).to match_array(retweets)
    end
  end
end
