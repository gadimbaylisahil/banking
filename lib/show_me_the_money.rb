require 'active_record'
require_relative 'banking/models/bank'
require_relative 'banking/models/transaction'
require_relative 'banking/models/transfer'
require_relative 'banking/models/account'
require_relative 'banking/services/transfer_agent_service'

def db_configuration
	db_configuration_file = File.join(File.expand_path('..', __FILE__), '..', 'db', 'config.yml')
	YAML.load(File.read(db_configuration_file))
end

ActiveRecord::Base.establish_connection(db_configuration["development"])
jims_bank = Bank.create(name: 'Bank of Jim')
emmas_bank = Bank.create(name: 'Bank of Emma')

jims_account = Account.create(name: 'Jim', balance: '100000', bank: jims_bank)
emmas_account = Account.create(name: 'Emma', balance: '75000', bank: emmas_bank)

owed_amount = 20000

transfer = Transfer.create(transfer_amount: owed_amount, account: jims_account)

puts "Jim's balance before transfer #{jims_account.balance}"
puts "Emma's balance before transfer #{emmas_account.balance}"

# Transferring
TransferAgentService.new(transfer: transfer, from: jims_account, to: emmas_account).call

puts "Jim's balance after transfer #{jims_account.balance}, he paid #{transfer.commission} in commission"
puts "Emma's balance after transfer #{emmas_account.balance}"

puts "Transfer status: #{transfer.status}"
puts "Total number of successful
			transactions needed to complete the transfer is: #{transfer.transactions.where(status: 'completed').count}"

# History of trxs(all transactions complted or failed)
puts "Total number of transactions needed to be performed.(Including failed ones): #{transfer.transactions.count}"
transfer.transactions.each_with_index do |trx, index|
	puts "Transaction no #{index + 1}. Amount: #{trx.amount}€. Status: #{trx.status}"
end

# Also transactions can be accessed by the Bank instances
puts "All transactions for #{jims_bank.name}"

jims_bank.transactions.each_with_index do |trx, index|
	puts "Transaction no #{index + 1}. Amount: #{trx.amount}€. Status: #{trx.status}"
end