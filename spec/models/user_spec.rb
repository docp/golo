require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :name => "Max Mustermann",
		          :email => "max@mustermann.de",
		          :password => "Geheim_Geheim",
		          :password_confirmation => "Geheim_Geheim" }
	end

	it "should create new instance given valid attributes" do
		User.create!(@attr)
	end

  it "should require a name" do
  	no_name_user = User.create(@attr.merge(:name => ""))
  	no_name_user.should_not be_valid
  end

  it "should require an email adress" do
  	no_email_user = User.create(@attr.merge(:email => ""))
  	no_email_user.should_not be_valid
  end

  it "should have username shorter than 32 characters" do
    tooloong_name_user = User.create(@attr.merge(:name => "a" * 33))
    tooloong_name_user.should_not be_valid
  end

  it "should reject invalid email adresses" do
    invalid_emails = %w{foo(at)bar.com}
    invalid_emails.each do |iv_e|
      invalid_email_user = User.create(@attr.merge(:email => iv_e))
      invalid_email_user.should_not be_valid
    end
  end

  it "should accept valid email adresses" do
    valid_emails = %w{eins@gmail.com Zwei@YAHOO.DE dRei@rocketmail.com
      VIER@rocketmail.com fuenF@YAHOO.DE se.chs@YAHOO.DE sie_ben@rocketmail.com}
    valid_emails.each do |v_e|
      valid_email_user = User.create(@attr.merge(:email => v_e))
      valid_email_user.should be_valid
    end
  end

  it "should not allow more than one user per email adress" do
    usr = User.create(@attr)
    duplicate_email_usr = User.create(@attr.merge(:name => "Maexchen",
                                               :email => @attr[:email].upcase))
    duplicate_email_usr.should_not be_valid
  end

  describe "password validation" do


    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation =>"")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should ensure that the encrypted password is not blank" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
    end

    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_pw_user = User.authenticate(@attr[:email], "wrong_password")
        wrong_pw_user.should be_nil
      end

      it "should return nil for an email address without associated user" do
        nonexisting_user = User.authenticate("nonexisting@address.zz",
                                              @attr[:password])
        nonexisting_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end
  describe "relationships" do

    before(:each) do
      @user = User.create!(@attr)
      @followed = Factory(:user, :email => Factory.next(:email))
    end

    it "should have a relationship model" do
      @user.should respond_to(:relationships)
    end
  end
end

