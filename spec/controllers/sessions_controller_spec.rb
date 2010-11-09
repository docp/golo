require 'spec_helper'

describe SessionsController do

  render_views

  before(:each) do
    @base_title = "Golo"
  end
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end

  it "should have the right title" do
    get :new
    response.should have_selector("title",
                                  :content => @base_title + " | Login")
  end

  describe "POST 'create'" do

    describe "with invalid login data submitted" do

      before(:each) do
        @attr = { :email => "any@email.com", :password => "invalid"}
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should have the right title" do
        post :create, :session => @attr
        response.should have_selector('title',
                                      :content => @base_title + " | Login")
      end

      it "should habe a flash.now massage" do
        post :create, :session => @attr
        flash.now[:error].should =~ /unknown/i
      end
    end

    describe "login valid login data submitted" do
      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_logged_in
      end

      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user.id))
      end
    end
  end

  describe "DELETE 'destroy'" do

    it "should logout a user who is logged in" do
      test_login(Factory(:user))
      delete :destroy
      controller.should_not be_logged_in
      response.should redirect_to(root_path)
    end
  end
end

