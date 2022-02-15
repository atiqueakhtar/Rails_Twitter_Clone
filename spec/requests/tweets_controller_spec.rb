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
      tweet1 = create :tweet_with_replies
      tweets = Array.new.push(tweet1)
      tweets.concat(tweet1.replies)

      get :index

      expect(assigns(:tweets)).to match_array(tweets)
    end

    it 'ensures correct tweets are shown when user logged in' do
      Current.user = create :user
      session[:user_id] = Current.user.id
      followee1 = create :user
      create :relation, follower: Current.user, followee: followee1
      tweet1 = create :tweet, user: followee1
      tweet2 = create :tweet, user: followee1
      tweets = Array.new.push(tweet1)
      tweets.push(tweet2)

      get :index

      expect(assigns(:tweets)).to match_array(tweets)
    end
  end

  describe "GET /show" do
    it 'renders show page' do
      tweet = create :tweet_with_replies

      params = {id: tweet.id}
      get :show, params: params

      expect(response.status).to eq(200)
      expect(response).to render_template("show")
    end

    it 'ensures correct tweet and replies are shown' do
      tweet = create :tweet_with_replies
      
      params = {id: tweet.id}
      get :show, params: params

      expect(assigns(:tweet)).to eq(tweet)
      expect(assigns(:replies)).to match_array(tweet.replies)
    end
  end

  describe "POST /create" do
    it 'checks response for create' do
      tweet = create :parent_tweet
      Current.user = tweet.user

      params = {body: tweet.body}
      post :create, params: params

      expect(response.status).to eq(302)
    end

    it 'creates new tweet' do
      tweet = create :parent_tweet
      Current.user = tweet.user
      
      params = {body: tweet.body}
      post :create, params: params

      expect(assigns(:tweet).body).to eq(tweet.body)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE /destroy" do
    it 'checks response for destroy' do
      tweet = create :parent_tweet

      params = {id: tweet.id}
      delete :destroy, params: params

      expect(response.status).to eq(302)
    end

    it 'destroys tweet' do
      tweet = create :parent_tweet
      
      params = {id: tweet.id}
      delete :destroy, params: params

      expect(assigns(:tweet).body).to eq(tweet.body)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /likes" do
    it 'renders likes page' do
      tweet = create :tweet_with_likes
      users = tweet.liked_by

      params = {id: tweet.id}
      get :likes, params: params

      expect(response.status).to eq(200)
      expect(response).to render_template("likes")
    end

    it 'ensures users who have liked the tweet are only shown' do
      tweet = create :tweet_with_likes
      users = tweet.liked_by

      params = {id: tweet.id}
      get :likes, params: params

      expect(assigns(:users)).to match_array(users)
    end
  end

  describe "POST /add_like" do
    it 'renders likes page' do
      tweet = create :parent_tweet
      like = create :like, tweet: tweet

      params = {id: tweet.id}
      post :add_like, params: params

      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end

    it 'likes tweet if not already liked' do
      tweet = create :parent_tweet
      Current.user = create :user

      params = {id: tweet.id}
      post :add_like, params: params

      expect(tweet.liked_by).to include(Current.user)
    end

    it 'removes like if already liked' do
      tweet = create :parent_tweet
      like = create :like, tweet: tweet
      Current.user = like.user

      params = {id: tweet.id}
      post :add_like, params: params

      expect(tweet.likes).to eq([])
    end
  end

  describe "GET /retweets" do
    it 'renders retweets page' do
      tweet = create :tweet_with_retweets
      retweets = tweet.retweets

      params = {id: tweet.id}
      get :retweets, params: params

      expect(response.status).to eq(200)
      expect(response).to render_template("retweets")
    end

    it 'ensures who have retweeted the tweet are only shown' do
      tweet = create :tweet_with_retweets
      retweets = tweet.retweets

      params = {id: tweet.id}
      get :retweets, params: params

      expect(assigns(:tweets)).to match_array(retweets)
    end
  end
end
