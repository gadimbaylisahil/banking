require 'spec_helper'
require 'banking/models/bank'

RSpec.describe Bank, type: :model do
	describe 'Creation' do
		context 'when its valid' do
			let(:bank){
				Bank.create(name: 'Bank of Mars')
			}
			it 'creates a bank' do
				expect(bank.name).to eq('Bank of Mars')
			end
		end
		
		context 'when name is invalid' do
			let(:bank){
				Bank.new(name: nil)
			}
			it 'throws an exception' do
				expect{ bank.save! }.to raise_exception(ActiveRecord::RecordInvalid)
			end
		end
	end
	
	describe 'Relationships' do
		let(:bank) {
			Bank.create(name: 'Bank of Mars')
		}
		
		it 'has many accounts' do
			expect(bank).to respond_to(:accounts)
		end
		
		it 'has many transfers' do
			expect(bank).to respond_to(:transfers)
		end
	end
end