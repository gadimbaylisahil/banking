class Bank < ActiveRecord::Base
	INTRA_BANK_COMMISSION = 0
	INTRA_BANK_FAILURE = 0
	INTRA_BANK_COMMISSION = 0
	
	INTER_BANK_COMMISSION = 5
	INTER_BANK_FAILURE = 30
	INTER_BANK_LIMIT = 1000
	
	validates :name, presence: true
	has_many :accounts
	has_many :transfers, through: :accounts
end