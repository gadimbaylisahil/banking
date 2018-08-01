require 'spec_helper'
require 'banking/models/transaction'

RSpec.describe Transaction, type: :model do
	describe 'Creation' do
		context 'when its valid' do
			let(:bank){
				Bank.create(name: 'Bank of Mars')
			}
			let(:account){
				Account.create(name: 'John Diggins', bank: bank, balance: 2000)
			}
			let(:transfer){
				Transfer.create(transfer_amount: 1500, account: account)
			}
			let(:transaction){
				Transaction.create(transfer: transfer, amount: 500)
			}
			it 'creates a transaction' do
				expect(transaction.amount).to eq(500)
				expect(transaction.transfer).to eq(transfer)
			end
			it 'sets status to processing' do
				expect(transaction.status).to eq('processing')
			end
		end
		
		context 'when amount is invalid' do
			let(:bank){
				Bank.create(name: 'Bank of Mars')
			}
			let(:account){
				Account.create(name: 'John Diggins', bank: bank, balance: 2000)
			}
			let(:transfer){
				Transfer.new(transfer_amount: 0, account: account)
			}
			let(:transaction){
				Transaction.create(transfer: transfer, amount: 0)
			}
			it 'throws an exception' do
				expect{ transfer.save! }.to raise_exception(ActiveRecord::RecordInvalid)
			end
		end
		
		context 'when transfer is invalid' do
			let(:transaction){
				Transaction.new(amount: 500, transfer: nil)
			}
			it 'throws an exception' do
				expect{ transaction.save! }.to raise_exception(ActiveRecord::StatementInvalid)
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
		let(:transfer){
			Transfer.create(transfer_amount: 1500, account: account)
		}
		let(:transaction){
			Transaction.create(transfer: transfer, amount: 500)
		}
		
		it 'belongs to transfer' do
			expect(transaction).to respond_to(:transfer)
		end
		
	end
end