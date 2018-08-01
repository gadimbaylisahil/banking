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
			it 'creates a bank' do
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
				Account.new(bank: nil)
			}
			it 'throws an exception' do
				expect{ account.save! }.to raise_exception(ActiveRecord::RecordInvalid)
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
end