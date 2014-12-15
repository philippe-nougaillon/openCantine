#require "digest/sha2"
require 'concerns/logmodule.rb'

class User < ActiveRecord::Base
  include LogModule
  
  attr_protected :id

  belongs_to :ville, :foreign_key => "mairie_id"
  has_many :logs

  validates_presence_of :username
  validates_uniqueness_of :username

  def password=(pass)
    salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
    self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(pass + salt)
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    if user.blank? || password  != user.password_hash
       return nil
    else
       return user
    end
  end

  def self.authenticate2(username, password)
     user = User.find_by_username(username)
	   hash = Digest::SHA256.hexdigest(password + user.password_salt)
     if user.blank? || hash != user.password_hash
       return nil
	   end
     user
  end

end
