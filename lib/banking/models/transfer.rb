class Transfer < ActiveRecord::Base
	
	belongs_to :account
	has_many :transactions
	
	validates :transfer_amount, numericality: { greater_than: 0 }
	before_create :set_pending_amount
	
	private
	
	def set_pending_amount
		self.pending_amount = transfer_amount
	end
end