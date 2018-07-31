class Bank < ActiveRecord::Base
	validates :name, presence: true
	has_many :accounts
	has_many :transfers
end