class Person < ActiveRecord::Base
	belongs_to :user
	has_many :posts
	has_many :messages
	has_many :conversation_statuses
	has_many :conversations, :through => :conversation_statuses
	has_many :invitations
	has_many :mentions
	has_many :group_memberships
	has_many :groups, :through => :group_memberships
	has_many :group_admins
	has_many :groups, :through => :group_admins
	has_many :actors
	has_many :actions, :through => :actors
	has_many :comments
	has_many :aspect_memberships
	has_many :aspects, :through => :aspect_memberships
	has_many :albums
	has_many :notifications
	has_many :videos

	#validates :profile_link, :format => { :with => /\A[a-zA-Z]+\z/ }
    
end
