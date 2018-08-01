require 'spec_helper'
require 'banking/services/transfer_agent_service'

RSpec.describe TransferAgentService do
	let(:bank_a){
		Bank.create(name: 'Bank of Mars')
	}
	let(:bank_b){
		Bank.create(name: 'Bank of Jupiter')
	}
	let(:account_from){
		Account.create(balance: 30000, bank: bank_a, name: 'Jim ')
	}
	let(:account_to){
		Account.create(balance: 50000, bank: bank_b, name: 'Emma')
	}
	let(:transfer){
		Transfer.create(transfer_amount: 200000, account: account_from)
	}
	describe 'Initialization' do
		let(:transfer_agent){
			TransferAgentService.new(transfer: transfer, from: account_from, to: account_to)
		}
		it 'holds transfer' do
			expect(transfer_agent.transfer).to eq(transfer)
		end
		it 'holds from account' do
			expect(transfer_agent.from).to eq(account_from)
		end
		it 'holds to account' do
			expect(transfer_agent.to).to eq(account_to)
		end
	end
end