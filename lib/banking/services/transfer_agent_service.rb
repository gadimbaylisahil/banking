class TransferAgentService
	attr_reader :transfer
	attr_reader :from
	attr_reader :to
	
	def initialize(transfer:, from:, to:)
		@transfer = transfer
		@from = from
		@to = to
	end
	
	def call
	
	end
	
	private
	
end