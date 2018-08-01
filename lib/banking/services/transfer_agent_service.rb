class TransferAgentService
	attr_reader :transfer
	attr_reader :from
	attr_reader :to
	
	def initialize(transfer:, from:, to:)
		@transfer = transfer
		@from = from
		@to = to
		@commissions = 0
	end
	
	def call
		while @transfer.pending_amount > 0
			add_commission
			process_transaction
		end
		deduct_commission_from_sender
		mark_transfer
	end
	
	private
	
	def add_commission
		@commissions += commission
	end
	
	def remove_commission
		@commissions -= commission
	end

	def commission
		return Bank::INTRA_BANK_COMMISSION if intra_bank?
		Bank::INTER_BANK_COMMISSION
	end
	
	def process_transaction
		trx = create_transaction
		if trx.status == 'completed'
			# If transaction succeds, pending amount is deducted
			@transfer.pending_amount -= trx.amount
		else
			# If transaction fails, commission is returned
			remove_commission
		end
	end
	
	def create_transaction
		if intra_bank?
			trx = @transfer.transactions.create(amount: @transfer.pending_amount)
		else
			amount = select_transfer_amount
			trx = @transfer.transactions.create(amount: amount)
		end
		if is_transferred?
			trx.update(status: 'completed')
			add_to_receiver(trx.amount)
			deduct_from_sender(trx.amount)
		else
			trx.update(status: 'failed')
		end
		trx
	end
	
	def is_transferred?
		if intra_bank?
			return true if Bank::INTRA_BANK_FAILURE == 0
			Bank::INTRA_BANK_FAILURE > Random.rand(100)
		else
			return true if Bank::INTER_BANK_FAILURE == 0
			Bank::INTER_BANK_FAILURE > Random.rand(100)
		end
	end
	
	def select_transfer_amount
		if Bank::INTER_BANK_LIMIT > @transfer.pending_amount
			@transfer.pending_amount
		else
			Bank::INTER_BANK_LIMIT
		end
	end
	
	def add_to_receiver(amount)
		@to.balance += amount
		@to.save
	end
	
	def deduct_from_sender(amount)
		@from.balance -= amount
		@from.save
	end
	
	def intra_bank?
		@from.bank == @to.bank
	end
	
	def deduct_commission_from_sender
		@from.balance -= @commissions
		@from.save
	end
	
	def mark_transfer
		@transfer.commission = @commissions
		@transfer.status = 'completed'
		@transfer.save
	end
end