class Task < ActiveRecord::Base
	
	belongs_to :user
	
	validates :description, presence: true
	validates :user_id, presence: true
	validates :performer, presence: true
end
