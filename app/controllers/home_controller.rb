class HomeController < ApplicationController
  def index
  end

  def you
    session[:user] = User.find(1)
    @links = UserLinks.find_all_by_parent_user_id(session[:user].id)
    if(!@links.nil?)
      @links.each do |l|
        session[:user].add_buddy(User.find(l.child_user_id));
      end
    end
  end
end
