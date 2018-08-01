class Account < ActiveRecord::Base
	belongs_to :bank
	has_many :transfers
	has_many :transactions, through: :transfers
	validates :name, presence: true
	validates :balance, presence: { default: 0 }
	
	def sent_transactions
		Transaction.joins(:transfer).where( transfers: { account_id: self.id }).where(status: 'completed')
	end
	
	def received_transactions
		Transaction.joins(:transfer).where.not( transfers: { account_id: self.id }).where(status: 'completed')
	end
	
	def all_transactions
		sent_transactions + received_transactions
	end
end