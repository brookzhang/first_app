require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name" , :with=>""
          fill_in "Email",  :with=>""
          fill_in "Password", :with=>""
          fill_in "confirmation",:with=>""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User,:count)
      end
    end
    
    describe "success" do
      it "should make a new user " do
        lambda do
          visit signup_path
          fill_in "Name" , :with => "eeeeeeeee"
          fill_in "Email" , :with=> "eeeeee@ee.com"
          fill_in "Password" , :with=>"eeeeee"
          fill_in "Confirmation" , :with=>"eeeeee"
          click_button
          response.should have_selector("div.flash.success",:content=>"Welcome")
          response.should render_template("users/show")
        end.should change(User,:count).by(1)
      end
    end
    
  end
  
  
  describe "sign in/out" do
    describe "failure" do
      it "should not sign a user in" do
        user = User.new(:email=>"",:password=>"")
        integration_sign_in(user)
        response.should have_selector("div.flash.error",:content=>"Invalid")
      end
    end
    
    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        integration_sign_in(user)
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
    
  end
  
  
  describe "admin attribute" do
    before(:each) do
      @user = User.create!(@attr)
    end
    it "should respond to admin" do
      @user.should respond_to(:admin)
    end
    it "should not be an admin by default" do
      @user.should_not be_admin
    end
    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
  
  
  describe "micropost association" do
    before(:each) do
      @user = User.create(@attr)
      @mp1 = Factory(:micropost , :user=>@user , :created_at => 1.day.ago)
      @mp2 = Factory(:micropost , :user=>@user , :created_at => 1.hour.ago)
    end
    
    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end
    
    it "should have the right microposts in the right order" do
      @user.microposts.should == [@mp2,@mp1]
    end
    
    it "should destroy associated microposts" do
      @user.destroy
      [@mp1,@mp2].each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end
  end
  
  
end
