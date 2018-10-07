require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    # generate mock data
    before (:each) do
        @mock_movie_attributes = {:title => 'Star Wars', :release_date => '1977-05-25', :rating => 'PG'}
        @mock_movie = FactoryGirl.create(:movie)
    end
    
    # test creat method
    describe "POST #create" do
        it "saves the new movie in the database" do
            post :create, movie: @mock_movie_attributes
            expect {
                post :create, movie: @mock_movie_attributes
            }.to change(Movie,:count).by(1) 
        end
        it "assigns the saved movie to @movie" do
            post :create, movie: @mock_movie_attributes
            expect(assigns(:movie).title).to eq("Star Wars")
        end
        it "shows succefully creating masseage" do
            post :create, movie: @mock_movie_attributes
            expect(flash[:notice]).to eq("Star Wars was successfully created.")
        end
        it "redirects to the home page" do
            post :create, movie: @mock_movie_attributes
            expect(response).to redirect_to(:action => 'index')
        end
    end
    
    # test show method
    describe "GET #show" do
        it "retrieve movie ID from URI route" do
            get :show, id: @mock_movie
            expect(assigns(:movie).id).to eq 1
        end    
        
        it "assigns the requested movie to @movie" do
            get :show, id: @mock_movie
            expect(assigns(:movie).title).to eq("Blade Runner")
        end
        it "renders the :show template" do
            get :show, id: @mock_movie
            expect(response).to render_template(:show)
        end
    end
    
    # test update method
    describe "PUT #update" do
        it "finds the requested movie" do
            put :update, id: @mock_movie, movie: @mock_movie_attributes
            expect(assigns(:movie)).to eq(@mock_movie)
        end
        it "changes the requested movies attributes" do
            put :update, id: @mock_movie, movie: @mock_movie_attributes
            @mock_movie.reload
            expect(@mock_movie.title).to eq("Star Wars")
            expect(@mock_movie.release_date).to eq("1977-05-25")
        end
        it "shows succefully updated masseage" do
            put :update, id: @mock_movie, movie: @mock_movie_attributes
            expect(flash[:notice]).to eq("Star Wars was successfully updated.")
        end
        it "redirects to the updated movie" do
            put :update, id: @mock_movie, movie: @mock_movie_attributes
            expect(response).to redirect_to @contact
        end
    end
    
    # test delete method
    describe "DELETE #destroy" do
        it "deletes the movie" do
            expect{
                delete :destroy, id: @mock_movie
            }.to change(Movie,:count).by(-1)
            end
        it "shows succefully deleted masseage" do
            delete :destroy, id: @mock_movie
            expect(flash[:notice]).to eq("Movie 'Blade Runner' deleted.")
        end
        it "redirects to the main page " do
            delete :destroy, id: @mock_movie
            expect(response).to redirect_to(:action => 'index') 
        end
    end
end
