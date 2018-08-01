class Transfer < ActiveRecord::Base
	belongs_to :account
	has_many :transactions
	
	validates :transfer_amount, numericality: { greater_than: 0 }
end