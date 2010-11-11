class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def search
    @title = "Find People"
    if params[:search]
      @users = User.find_all_by_city(params[:search])
    else
      @users = nil
    end
  end
end

