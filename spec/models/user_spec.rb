require 'spec_helper'

describe User do
  before(:each) do
    @attr={:name=>"bbb",:email=>"bbb@bb.com"}
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name " do
    no_name_user = User.new(@attr.merge(:name=>""))
    no_name_user.should_not be_valid
  end
  
  it "should require a email" do
    no_email_user = User.new(@attr.merge(:email=>""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name=>long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email address"do
    addresses = %w[user@fo.com THE_USER@foo.bar.org first.last@foo.cn]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email=>address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@ff,com user_at.org emg.rr@ff.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email=>address))
      invalid_email_user.should_not be_valid
    end
  end
end
