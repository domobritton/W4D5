# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
#validations
#associations
#errors 
#methods

require 'rails_helper'

RSpec.describe User, type: :model do
  
  before(:each) do 
    @john = User.create(username: 'Johnjohn', password: 'asdfef')
  end 
  
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_uniqueness_of(:username) }
  
  describe 'session_token' do 
    it 'assigns session_token if not given' do
      #check out line 30
      # john = User.create(username: 'Johnjohn', password: 'asdfef')
      # john = User.find_by(username: 'Johnjohn')
      expect(@john.session_token).to be_present
    end 
  end 
  
  describe 'User::find_by_credentials' do 
    # john = User.create(username: 'Johnjohn', password: 'asdfef')
    it 'finds user with matching credentials' do 
      user = User.find_by_credentials('Johnjohn', 'asdfef')
      expect(user.username).to eq('Johnjohn')
    end 
    
    it 'returns nil if user credentials dont match' do
      user = User.find_by_credentials('Johnjohn', '')
      expect(user).to be_nil  
    end 
  end 
  
  describe 'User#reset_session_token!' do 
    it 'sets a new session token' do 
      # john = User.create(username: 'Johnjohn', password: 'asdfef')
      john = User.find_by(username: 'Johnjohn')
      old_session_token = john.session_token
      john.reset_session_token!
      expect(old_session_token).not_to eq(john.session_token)
    end 
  end 
  
  describe 'User#password=' do 
    it 'sets a new password_digest' do
      john = User.create(username: 'Johnjohn2', password: 'asdfef')
      old_password_digest = john.password_digest
      john.password = 'loremipsumdolorsitamet'
      expect(old_password_digest).not_to eq(john.password_digest)
    end 
  end
  
  describe 'User#is_password?' do 
    it 'should return a false when invalid' do 
      john = User.create(username: 'Johnjohn3', password: 'asdfef')
      expect(john.is_password?('john')).to be_falsy
    end
    
    it 'should return a true when valid' do 
      john = User.create(username: 'Johnjohn4', password: 'asdfef')
      expect(john.is_password?('asdfef')).to be_truthy
    end 
  end 
end
