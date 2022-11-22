require 'rails_helper'

RSpec.describe User, type: :model do
    describe "Validations" do 
    # validation tests/examples here
    it 'should confirm its a valid user' do 
      @user = User.new
      @user.name = 'Paris'
      @user.email = 'test@test.com'
      @user.password = 'test'
      @user.password_confirmation = 'test'
      @user.save
      expect(@user.valid?).to be true
    end

    # must be created with password and password confirmation
    it 'should error if wrong password' do
      @user = User.new 
      @user.name = 'Paris'
      @user.email = 'test@test.com'
      @user.password = 'wrong'
      @user.password_confirmation = '0'
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end 

    it 'should not error if correct password' do
      @user = User.new 
      @user.name = 'Paris'
      @user.email = 'test@test.com'
      @user.password = 'test'
      @user.password_confirmation = 'test'
      @user.save
      expect(@user.errors.full_messages).to_not include("Password confirmation doesn't match Password")
    end

    # emails must be unique, not case sensitive 
    it 'should not allow case-sensitive emails upon registration' do
      @user1 = User.new
      @user1.name = 'Paris'
      @user1.email = 'test@test.com'
      @user1.password = 'test'
      @user1.password_confirmation = "test"
      @user1.save

      @user2 = User.new
      @user2.name = 'Paris'
      @user2.email = "TEST@TEST.COM"
      @user2.password = "test"
      @user2.password_confirmation = "test"
      @user2.save

      expect(@user2.id).to_not be_present
    end


    # email, first name and last name should be required
    it 'should fail if email is not entered' do 
      @user = User.new 
      @user.name = 'Paris'
      @user.email = ''
      @user.password = 'test'
      @user.password_confirmation = 'test'
      @user.save
      expect(@user.valid?).to be false
    end

    it 'should fail if name is not entered' do 
      @user = User.new 
      @user.name = ''
      @user.email = 'test@test.com'
      @user.password = 'test'
      @user.password_confirmation = 'test'
      @user.save
      expect(@user.valid?).to be false
    end

    # password must have a minimum length when user is being created
    it 'should fail if password is under 4 characters' do
      @user = User.new
      @user.name = 'Paris'
      @user.email = 'test@test.com'
      @user.password = "tst"
      @user.password_confirmation = "test"
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should pass if password is 4 or more characters' do 
      @user = User.new
      @user.name = 'Paris'
      @user.email = 'test@test.com'
      @user.password = "test"
      @user.password_confirmation = "test"
      @user.save
      expect(@user.errors.full_messages).to_not include("Password confirmation doesn't match Password")
    end

    describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should authenticate user when logged in' do
      @user = User.create(name: 'Paris', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      user_logged_in = User.authenticate_with_credentials('test@test.com', 'test')
      excpect(user_logged_in).to eq @user
    end

    # white space for email address
    it 'should log user in with white-space in email' do 
      @user = User.create(name: 'Paris', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      user_logged_in = User.authenticate_with_credentials('   test@test.com   ', 'test')
      excpect(user_logged_in).to eq @user
    end

  #  wrong case can sign in
    it 'should log in with case-sensitive email' do 
      @user = User.create(name: 'Paris', email: 'test@test.com', password: 'test', password_confirmation: 'test')
      user_logged_in = User.authenticate_with_credentials('TEST@TEST.com', 'test')
      excpect(user_logged_in).to eq @user
    end
  end
end
end