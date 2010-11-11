require 'spec_helper'

describe UsersController do
  render_views

  before(:each) do
    @base_title = "Golo"
  end

  describe "GET 'show'" do
    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id => @user.id
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user.id
      response.should have_selector('title',
                                    :content => @base_title +" | " + @user.name)
    end

    it "should have the right title" do
      get :show, :id => @user.id
      response.should have_selector('h1',
                                    :content => @user.name)
    end
  end

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title",
                                    :content => @base_title + " | Sign up")
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => ""}
      end
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title",
                                    :content => @base_title + " | Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end

    describe "success" do
      before(:each) do
		  @attr = { :name => "Max Mustermann",
		            :email => "max@mustermann.de",
		            :city => "Musterstadt.de",
		            :password => "Geheim_Geheim",
		            :password_confirmation => "Geheim_Geheim" }
	    end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should generate a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the track database/i
      end
#      No Way found to test the ridirect with rspec, should be possible with webrat
#      it "should display a welcome message" do
#        post :create, :user => @attr
#        response.should have_selector(:div,
#                                  :content => "Welcome to the " + @base_title)
#      end

      it "should sign created user in" do
        post :create, :user => @attr
        controller.should be_logged_in
      end
    end
  end
end

