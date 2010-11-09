require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Golo"
  end

  describe "GET 'home'" do
    it "should load successful" do
      get 'home'
      response.should be_success
    end
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                    :content => @base_title + " | Home")
    end
  end

  describe "GET 'contact'" do
    it "should load successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should load successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                      :content => @base_title + " | About")
    end
    it "should contain written by paul" do
      get 'about'
      response.should have_selector("body", :content => "written by paul")
    end
  end

  describe "GET help" do
    it "help should load successful" do
      get "help"
      response.should be_success
    end
    it "site should have the right title" do
      get "help"
      response.should have_selector("title",
                                    :content => @base_title + " | Help")
    end
  end
end

