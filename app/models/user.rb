class User < ActiveRecord::Base
  has_many :user_links, :class_name => 'UserLinks', :foreign_key => 'parent_user_id'
  @buddies = Array.new
  def get_buddies
    if (@buddies.nil?)
      @buddies = Array.new
    end
    @buddies
  end
  def add_buddy(buddy)
    if (@buddies.nil?)
      @buddies = Array.new
    end
    @buddies << buddy
  end
end
