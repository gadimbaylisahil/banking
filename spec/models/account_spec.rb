require 'spec_helper'
require 'banking/models/account'

RSpec.describe Account, type: :model do
	describe 'Creation' do
		context 'when its valid' do
			let(:bank){
				Bank.create(name: 'Bank of Mars')
			}
			let(:account){
				Account.create(name: 'John Diggins', bank: bank, balance: 2000)
			}
			it 'creates an account' do
				expect(account.name).to eq('John Diggins')
				expect(account.balance).to eq(2000)
				expect(account.bank).to eq(bank)
			end
		end
		
		context 'when name is invalid' do
			let(:account){
				Account.new(name: nil)
			}
			it 'throws an exception' do
				expect{ account.save! }.to raise_exception(ActiveRecord::RecordInvalid)
			end
		end
		context 'when balance is invalid' do
			let(:account){
				Account.new(balance: nil)
			}
			it 'throws an exception' do
				expect{ account.save! }.to raise_exception(ActiveRecord::RecordInvalid)
			end
		end
		context 'when bank is invalid' do
			let(:account){
				Account.new(bank: nil, balance: 2000, name: 'John Diggins')
			}
			it 'throws an exception' do
				expect{ account.save! }.to raise_exception(ActiveRecord::StatementInvalid)
			end
		end
	end
	
	describe 'Relationships' do
		let(:bank) {
			Bank.create(name: 'Bank of Mars')
		}
		let(:account) {
			Account.create(name: 'John Diggins', bank: bank, balance: 2000)
		}
		
		it 'belongs to bank' do
			expect(account).to respond_to(:bank)
		end
		
		it 'has many transfers' do
			expect(account).to respond_to(:transfers)
		end
	end
	
	describe 'Decorators' do
		let(:bank_a){
			Bank.create(name: 'Bank of Mars')
		}
		let(:bank_b){
			Bank.create(name: 'Bank of Jupiter')
		}
		let(:jims_account){
			Account.create(balance: 30000, bank: bank_a, name: 'Jim ')
		}
		let(:emmas_account){
			Account.create(balance: 50000, bank: bank_b, name: 'Emma')
		}
		let(:transfer){
			Transfer.create(transfer_amount: 20000, account: jims_account)
		}
		let(:second_transfer){
			Transfer.create(transfer_amount: 20000, account: emmas_account)
		}
		
		before do
			TransferAgentService.new(transfer: transfer, from: jims_account, to: emmas_account).call
			TransferAgentService.new(transfer: transfer, from: emmas_account, to: jims_account).call
		end
		
		it 'returns sent transaction history on #sent_transactions method' do
			expect(jims_account.sent_transactions.count).to eq(transfer.transactions.where(status: 'completed').count)
		end
		
		it 'returns received transactions history on #received_transactions method' do
			expect(emmas_account.received_transactions.count).to eq(transfer.transactions.where(status: 'completed').count)
		end
		
		it 'returns all completed transactions history on #all_transactions method' do
			expect(jims_account.all_transactions.count).to eq(transfer.transactions.where(status: 'completed').count +
			                                                  second_transfer.transactions.where(status: 'completed').count)
		end
	end
end