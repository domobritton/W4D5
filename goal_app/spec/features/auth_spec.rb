require 'spec_helper'
require 'rails_helper'

feature 'go_app' do 
  background :each do 
    visit new_user_path
  end  
 

  feature 'the signup process' do
    scenario 'has a new user page' do 
      expect(page).to have_content('Users sign up')
    end
    
    scenario 'takes a username and password' do 
      expect(page).to have_content('Username')
      expect(page).to have_content('Password')
    end 
    
    feature 'sign up new user with valid params' do
      before(:each) do 
        fill_in 'Username', with: 'Steve1'
        fill_in 'Password', with: '123456'
        click_button 'Submit'
      end 
      
      scenario 'redirect to new session' do
        expect(page).to have_content('Steve1')
      end 
      
    end
    
    feature 'renders new user with invalid params' do
      before(:each) do 
        fill_in 'Username', with: 'Steve'
        fill_in 'Password', with: '12'
        click_button 'Submit'
      end 
      
      scenario 'flash error' do 
        expect(page).to have_content('Password is too short')
      end 
      
      scenario 'render to new user' do 
        expect(page).to have_content('Users sign up')
      end 
    end
  end
  
  feature 'show' do 
    before(:each) do 
      fill_in 'Username', with: 'Steve1'
      fill_in 'Password', with: '123456'
      click_button 'Submit'
    end 

    feature 'the show page' do 
      scenario 'show user name' do 
        expect(page).to have_content('show page')
      end 
    end 
  end 
  
  
end

