# == Schema Information
# Schema version: 20101101173124
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'digest' # required for encryption

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name,
                  :email,
                  :password,
                  :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :password, :confirmation => true automatically creates virtual
  #attribute password_confirmation which is checked to be maching the password.
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 10..40 }
  validates :name, :presence => true,
                   :length => { :maximum => 32 }
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => { :with => email_regex }
  before_save :encrypt_password

  # authentication func, returns user if valid email/pw combination, else nil
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  # Return true if the users's password matches the submitted passowrd
  def has_password?(submitted_password)
    # compare encrypted_password with the encrypted version of
    # submitted password
    encrypted_password == encrypt(submitted_password)
  end

  private

    def encrypt_password
      # create salt only for new user, not when checking if password matches
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(self.password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end

