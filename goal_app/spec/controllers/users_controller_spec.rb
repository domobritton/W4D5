require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe 'GET #new' do 
    it 'renders new sign up page' do 
      get :new 
      
      expect(response).to render_template(:new)
    end 
  end 
  
  #ask how to access rspec database
  
  describe 'POST #create' do 
    context 'with valid params' do 
      it 'redirect_to user show page' do 
        post :create, params: {user: {username: 'Johnjohn1', password: 'assdff'}}
        user = User.find_by(username: 'Johnjohn1')
        expect(response).to redirect_to(user_url(user))
      end 
    end 
    
    context 'with invalid params' do 
      it 'recirect to new with errors' do 
        post :create, params: {user: {username: 'Johnjohn2', password: ''}}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end 
    end 
  end 
  
  
end
