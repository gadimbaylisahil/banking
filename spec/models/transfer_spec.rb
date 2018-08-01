require 'spec_helper'
require 'banking/models/transfer'

RSpec.describe Transfer, type: :model do
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
			it 'creates a transfer' do
				expect(transfer.transfer_amount).to eq(1500)
				expect(transfer.account).to eq(account)
			end
			it 'sets status to pending' do
				expect(transfer.status).to eq('pending')
			end
		end
		
		context 'when transfer_amount is invalid' do
			let(:bank){
				Bank.create(name: 'Bank of Mars')
			}
			let(:account){
				Account.create(name: 'John Diggins', bank: bank, balance: 2000)
			}
			let(:transfer){
				Transfer.new(transfer_amount: 0, account: account)
			}
			it 'throws an exception' do
				expect{ transfer.save! }.to raise_exception(ActiveRecord::RecordInvalid)
			end
		end
		context 'when account is invalid' do
			let(:transfer){
				Transfer.new(transfer_amount: 1000, account: nil)
			}
			it 'throws an exception' do
				expect{ transfer.save! }.to raise_exception(ActiveRecord::StatementInvalid)
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

		it 'belongs to account' do
			expect(transfer).to respond_to(:account)
		end

		it 'has many transactions' do
			expect(transfer).to respond_to(:transactions)
		end
	end
end