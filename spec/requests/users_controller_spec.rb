require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe 'GET /followers' do
        it 'returns all followers of a user' do
            user = create :user_with_followers

            get :followers, params: {id: user.id}

            expect(assigns(:followers)).to match_array(user.followers)
        end
    end

    describe 'POST /create' do
        it 'returns seached user' do
            user = create :user

            post :create, params: {username: user.username}

            expect(response.status).to eq(200)
        end

        it 'returns to home page on blank input' do
            user = create :user

            post :create, params: {username: ""}
            
            expect(assigns(:users)).to eq(nil)
            expect(response).to redirect_to(root_path)
        end

        it 'returns seached user' do
            user = create :user

            post :create, params: {username: user.username}

            expect(assigns(:users)).to match_array(user)
        end
    end

    describe 'GET /show' do
        it 'ensures if show user renders correctly' do
            user = create :user_with_followers
            tweet = create :tweet, user: user

            get :show, params: {id: user.id}

            expect(response.status).to eq(200)
            expect(response).to render_template("show")
        end

        it 'returns user, his/her tweets and followers' do
            user = create :user_with_followers
            tweet = create :tweet, user: user

            get :show, params: {id: user.id}

            expect(assigns(:tweets)).to match_array(user.tweets)
            expect(assigns(:followers)).to match_array(user.followers)
        end
    end

    describe 'PUT /update' do
        it 'follows user if not followed already' do
            user = create :user_with_followers
            Current.user = create :user

            expect{ put :update, params: {id: user.id} }.to change{ user.followers.count }.by(1)
        end

        it 'it unfollows user if followed already' do
            user = create :user_with_followers
            Current.user = create :user
            relation = create :relation, follower: Current.user, followee: user

            expect{ put :update, params: {id: user.id} }.to change{ user.followers.count }.by(-1)
        end
    end
end