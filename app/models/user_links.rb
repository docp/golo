class UserLinks < ActiveRecord::Base
  belongs_to :parent_user, :class_name => 'User', :foreign_key => "parent_user_id"
  belongs_to :child_user, :class_name => 'User', :foreign_key => "child_user_id"
  def parent_user
    
  end
end
